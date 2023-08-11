import 'package:iran_gpt/features/mian/domain/entites/save_data_entity.dart';

class SaveDataModel extends SaveDataEntity {
  SaveDataModel({required super.content, required super.created, required super.fromIs});

  factory SaveDataModel.fromEntity(SaveDataEntity saveDataEntity) {
    return SaveDataModel(
        content: saveDataEntity.content,
        created: saveDataEntity.created,
        fromIs: saveDataEntity.fromIs
    );
  }
}