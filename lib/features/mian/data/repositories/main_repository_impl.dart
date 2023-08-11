import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:iran_gpt/core/error/failure.dart';
import 'package:iran_gpt/features/mian/data/data_source/remote_data_source.dart';
import 'package:iran_gpt/features/mian/data/models/save_data_model.dart';
import 'package:iran_gpt/features/mian/data/models/value_bbject/main_params_dto.dart';
import 'package:iran_gpt/features/mian/domain/entites/main_entity.dart';
import 'package:iran_gpt/features/mian/domain/entites/save_data_entity.dart';
import 'package:iran_gpt/features/mian/domain/entites/value_object/main_params.dart';
import 'package:iran_gpt/features/mian/domain/repositories/mian_repository.dart';

import '../data_source/local_data_source.dart';

class MainRepositoryImpl extends MainRepository {
  RemoteDataSource remoteDataSource;
  LocalDataSource localDataSource;
  MainRepositoryImpl(this.remoteDataSource,this.localDataSource);

  @override
  Future<Either<Failure, MainEntity>> getContent(MainParams mainParams)async {
    try {
      final response = await remoteDataSource.getAnswerOfTheQuestion(MainParamsDto.fromEntity(mainParams));
      return Right(response);
    }catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SaveDataEntity>>> getAllData()async{
    final result = (await localDataSource.getAllData());
    try{
      return Right(result);
    }on HiveError catch(e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, int>> saveData(SaveDataEntity saveDataEntity)async{
    try {
      final int = await localDataSource.saveData(SaveDataModel.fromEntity(saveDataEntity));
      return Right(int);
    }on HiveError catch(e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, int>> deleteAll()async{
    try {
      return Right(await localDataSource.deleteAll());
    }on HiveError catch(e) {
      return Left(CacheFailure(e.message));
    }
  }







}