import 'package:hive/hive.dart';

import '../models/save_data_model.dart';

abstract class LocalDataSource {

  Future<int> saveData(SaveDataModel saveDataModel);
  Future<List<SaveDataModel>> getAllData();
  Future<int> deleteAll();
}

class LocalDataSourceImpl extends LocalDataSource {
  final Box _box = Hive.box("saveData");

  @override
  Future<int> saveData(SaveDataModel saveDataModel)async{
    return await _box.add(saveDataModel);
  }

  @override
  Future<List<SaveDataModel>> getAllData()async{
    return  _box.values.map((e) => SaveDataModel.fromEntity(e)).toList();
  }

  @override
  Future<int> deleteAll()async {
   return _box.clear();
  }



}