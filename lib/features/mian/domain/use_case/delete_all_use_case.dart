import 'package:dartz/dartz.dart';
import 'package:iran_gpt/core/error/failure.dart';
import 'package:iran_gpt/core/use_case/base_use_case.dart';
import 'package:iran_gpt/features/mian/domain/repositories/mian_repository.dart';

class DeleteAllUseCase extends BaseUseCase<int,NoParams> {
  MainRepository mainRepository;
  DeleteAllUseCase(this.mainRepository);

  @override
  Future<Either<Failure, int>> call(NoParams p) {
    return mainRepository.deleteAll();
  }


}