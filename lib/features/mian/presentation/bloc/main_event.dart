part of 'main_bloc.dart';

abstract class MainEvent extends Equatable {
  const MainEvent();
}

class SendDataEvent extends MainEvent {
  final MainParams mainParams;
  const SendDataEvent(this.mainParams);
  @override
  List<Object?> get props => [mainParams];
}

class SaveDataInDb extends MainEvent {
  final SaveDataEntity saveDataEntity;
  const SaveDataInDb(this.saveDataEntity);
  @override
  List<Object?> get props => throw UnimplementedError();
}

class GetAllDataEvent extends MainEvent {
  @override
  List<Object?> get props => [];
}
class DeleteAllHistoryEvent extends MainEvent {
  @override
  List<Object?> get props => throw UnimplementedError();

}

