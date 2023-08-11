import 'package:equatable/equatable.dart';

class MainParams extends Equatable {
  final String model;
  final List<Messages> messages;

  const MainParams({this.model = 'gpt-3.5-turbo',required this.messages});



  @override
  List<Object?> get props => [model,messages];
  Map toJson()=> {
    'model':model,
    'messages' :messages
  };
}

class Messages {
  final String role;
  final String content;
  Messages({this.role = 'user',required this.content});

  Map toJson()=> {
    'role':role,
    'content' :content
  };
}