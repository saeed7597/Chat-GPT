import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
part 'save_data_entity.g.dart';

@HiveType(typeId: 0)
class SaveDataEntity extends Equatable {
  @HiveField(0)
  String content = '';
  @HiveField(1)
  num created = 0;
  @HiveField(2)
  int fromIs = -1;
  @override

  SaveDataEntity({required this.content,required this.created,required this.fromIs});


  factory SaveDataEntity.fromEntity(SaveDataEntity saveDataEntity) {
    return SaveDataEntity(
        content: saveDataEntity.content,
        created: saveDataEntity.created,
        fromIs: saveDataEntity.fromIs
    );
  }
  @override
  List<Object?> get props => [content,created,fromIs];
}