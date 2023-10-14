import 'package:dartz/dartz.dart';
import 'package:iran_gpt/core/error/failure.dart';
import 'package:iran_gpt/features/mian/domain/entites/main_entity.dart';
import 'package:iran_gpt/features/mian/domain/entites/save_data_entity.dart';

import '../entites/value_object/main_params.dart';
abstract class MainRepository {

  Future<Either<Failure,MainEntity>> getContent(MainParams mainParams);
  Future<Either<Failure,List<SaveDataEntity>>> getAllData();
  Future<Either<Failure,int>> saveData(SaveDataEntity saveDataEntity);
  Future<Either<Failure,int>> deleteAll();
}