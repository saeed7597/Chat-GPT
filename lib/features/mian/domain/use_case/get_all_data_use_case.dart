import 'package:dartz/dartz.dart';
import 'package:iran_gpt/core/error/failure.dart';
import 'package:iran_gpt/core/use_case/base_use_case.dart';
import 'package:iran_gpt/features/mian/domain/entites/save_data_entity.dart';
import 'package:iran_gpt/features/mian/domain/repositories/mian_repository.dart';

class GetAllDataUseCase extends BaseUseCase<List<SaveDataEntity>,NoParams> {
  MainRepository mainRepository;
  GetAllDataUseCase(this.mainRepository);
  @override
  Future<Either<Failure, List<SaveDataEntity>>> call(NoParams p)async{
    return await mainRepository.getAllData();
  }

}