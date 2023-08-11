part of 'main_bloc.dart';

abstract class MainState extends Equatable {
  const MainState();
}

class MainInitial extends MainState {
  @override
  List<Object> get props => [];
}

class DoneData extends MainState {

  final MainEntity mainEntity;
  const DoneData(this.mainEntity);

  @override
  List<Object?> get props => [mainEntity];

}

class Loading extends MainState {
  @override
  List<Object?> get props => [];

}

class LoadingServer extends MainState {
  @override
  List<Object?> get props => [];

}

class DoneDataFailed extends MainState {
  final String message;
  const DoneDataFailed(this.message);
  @override
  List<Object?> get props => [message];
}

class SaveData extends MainState {
  @override
  List<Object?> get props => [];

}

class GetAllData extends MainState {
  final List<SaveDataEntity> data;
  const GetAllData(this.data);
  @override
  List<Object?> get props => [data];
}

class DeleteHistory extends MainState {
  @override
  List<Object?> get props => [];

}
