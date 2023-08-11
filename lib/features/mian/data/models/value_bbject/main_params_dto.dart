import 'package:iran_gpt/features/mian/domain/entites/value_object/main_params.dart';

class MainParamsDto extends MainParams {
  const MainParamsDto({required super.model, required super.messages});

  factory MainParamsDto.fromEntity(MainParams mainParams) {
    return MainParamsDto(model: mainParams.model, messages: mainParams.messages);
  }
}