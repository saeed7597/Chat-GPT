import 'package:dartz/dartz.dart';
import 'package:iran_gpt/core/error/failure.dart';
import 'package:iran_gpt/core/use_case/base_use_case.dart';
import 'package:iran_gpt/features/mian/domain/entites/save_data_entity.dart';

import '../repositories/mian_repository.dart';

class SaveDataUseCase extends BaseUseCase<int,SaveDataEntity> {
  final MainRepository mainRepository;
  SaveDataUseCase(this.mainRepository);

  @override
  Future<Either<Failure, int>> call(SaveDataEntity p)async{
    return await mainRepository.saveData(p);
  }





}