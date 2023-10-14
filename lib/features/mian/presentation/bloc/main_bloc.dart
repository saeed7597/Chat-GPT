import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:iran_gpt/core/use_case/base_use_case.dart';
import 'package:iran_gpt/features/mian/domain/entites/main_entity.dart';
import 'package:iran_gpt/features/mian/domain/entites/value_object/main_params.dart';

import '../../domain/entites/save_data_entity.dart';
import '../../domain/use_case/delete_all_use_case.dart';
import '../../domain/use_case/get_all_data_use_case.dart';
import '../../domain/use_case/main_use_case.dart';
import '../../domain/use_case/save_data_use_case.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final MainUseCase mainUseCase;
  final SaveDataUseCase saveDataUseCase;
  final GetAllDataUseCase getAllDataUseCase;
  final DeleteAllUseCase deleteAllUseCase;
  MainBloc(this.mainUseCase,this.saveDataUseCase,this.getAllDataUseCase,this.deleteAllUseCase) : super(MainInitial()) {
    on<SendDataEvent>(_sendData);
    on<SaveDataInDb>(_saveDataInDb);
    on<GetAllDataEvent>(_getAllData);
    on<DeleteAllHistoryEvent>(_deleteData);
  }

  _sendData(SendDataEvent event,Emitter<MainState> emit) async{
    emit(LoadingServer());
    final result = await mainUseCase.call(event.mainParams);
    result.fold(
            (failure) => emit(DoneDataFailed(failure.message)),
            (success) => emit(DoneData(success))
    );
  }

  _saveDataInDb(SaveDataInDb event,Emitter<MainState> emit)async{
    emit(Loading());
    final result = await saveDataUseCase.call(event.saveDataEntity);
    result.fold(
            (failure) => emit(DoneDataFailed(failure.message)),
            (success) => emit(SaveData())
    );
  }
  _getAllData(GetAllDataEvent event,Emitter<MainState> emit)async{
    emit(Loading());
    final result = await getAllDataUseCase.call(const NoParams());
    result.fold(
            (failure)=>emit(DoneDataFailed(failure.message)),
            (success) =>emit(GetAllData(success))
    );
  }

  _deleteData(DeleteAllHistoryEvent event,Emitter<MainState> emit)async{
    emit(Loading());
    final result = await deleteAllUseCase.call(const NoParams());
    result.fold(
            (failure) => emit(DoneDataFailed(failure.message)),
            (success) => emit(DeleteHistory())
    );
  }


}
