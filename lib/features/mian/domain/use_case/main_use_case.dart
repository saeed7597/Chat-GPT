import 'package:dartz/dartz.dart';
import 'package:iran_gpt/core/error/failure.dart';
import 'package:iran_gpt/core/use_case/base_use_case.dart';
import 'package:iran_gpt/features/mian/data/models/value_bbject/main_params_dto.dart';
import 'package:iran_gpt/features/mian/domain/entites/main_entity.dart';
import 'package:iran_gpt/features/mian/domain/entites/value_object/main_params.dart';
import 'package:iran_gpt/features/mian/domain/repositories/mian_repository.dart';

class MainUseCase extends BaseUseCase<MainEntity,MainParams> {
  final MainRepository mainRepository;
  MainUseCase(this.mainRepository);

  @override
  Future<Either<Failure, MainEntity>> call(MainParams p)async{
    return await mainRepository.getContent(p);
  }




}