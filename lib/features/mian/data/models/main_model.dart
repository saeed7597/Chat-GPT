import 'package:iran_gpt/features/mian/domain/entites/main_entity.dart';

class MainModel extends MainEntity {
  const MainModel({
    required super.id,
    required super.object,
    required super.created,
    required super.model,
    required super.usage,
    required super.choices});

  factory MainModel.fromJson(Map<String,dynamic> json) {
    return MainModel(
        id : json['id'],
        object : json['object'],
        created : json['created'],
        model: json['model'],
        usage : Usage.fromJson(json['usage']),
        choices:  List<Choices>.from((json['choices'] as List)
            .map((e) => Choices.fromJson(e))),
    );
  }



}