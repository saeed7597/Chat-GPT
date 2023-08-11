import 'package:equatable/equatable.dart';

class MainEntity extends Equatable {


  final String id;
  final String object;
  final num created;
  final String model;
  final Usage usage;
  final List<Choices> choices;  
  const MainEntity(
      {required this.id,
      required this.object,
      required this.created,
      required this.model,
      required this.usage,
      required this.choices});



  @override
  List<Object?> get props => [id,object,created,model,usage,choices];

}

class Usage {
  final int promptTokens;
  final int completionTokens;
  final int totalTokens;
  const Usage({required this.promptTokens,required this.completionTokens, required this.totalTokens});

  factory Usage.fromJson(Map json) {
    return Usage(
        promptTokens : json['prompt_tokens'],
        completionTokens : json['completion_tokens'],
        totalTokens : json['total_tokens']
    );
  }
}

class Choices {
  final Message message;
  final String finishReason;
  final int index;
  Choices({required this.message,required this.finishReason,required this.index});

  factory Choices.fromJson(Map<String,dynamic> json) {
    return Choices(
        message : Message.fromJson(json['message']),
        finishReason : json['finish_reason'],
        index:json['index']
    );
  }

}

class Message {
  final String role;
  final String content;
  const Message({
    required this.role,
    required this.content}
      );
  
  factory Message.fromJson(Map<String,dynamic> json) {
    return Message(
        role: json['role'],
        content: json['content']
    );
  }
}

