import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:iran_gpt/core/error/failure.dart';

abstract class BaseUseCase<T,P> {
  Future<Either<Failure,T>> call(P p);
}

class NoParams extends Equatable {
  const NoParams();
  @override
  List<Object?> get props => [];

}