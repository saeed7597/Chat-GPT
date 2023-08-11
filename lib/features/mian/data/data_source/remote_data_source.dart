import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:iran_gpt/features/mian/data/models/main_model.dart';
import 'package:iran_gpt/features/mian/data/models/value_bbject/main_params_dto.dart';

abstract class RemoteDataSource {

  Future<MainModel> getAnswerOfTheQuestion(MainParamsDto mainParamsDto);
}

class RemoteDataSourceImpl extends RemoteDataSource {
  @override
  Future<MainModel> getAnswerOfTheQuestion(MainParamsDto mainParamsDto)async {
    final Dio  dio = Dio();
    const authorization = 'your_token';
    dio.options.headers['Content-Type']  = 'application/json';
    dio.options.headers['Authorization'] = authorization;
    final response = await dio.post(
        'https://api.openai.com/v1/chat/completions',
        data:mainParamsDto
    );
    if (response.statusCode == 200) {
      return MainModel.fromJson(response.data);
    }throw {
      debugPrint('error')
    };
  }


}