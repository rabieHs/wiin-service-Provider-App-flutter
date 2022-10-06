import 'package:wiin/data/chat_messages_model.dart';
import 'package:wiin/data/post_model.dart';

class ChatModel{

  final String name;
  final String image;
  final List<ChatMessages> messages;
  final bool wasRead;
  ChatModel({required this.name, required this.image, required this.messages, required this.wasRead});
}
List<ChatModel> messages= [

  ChatModel(name: "amin ali", image: "https://ui-avatars.com/api/?name=Amin+Ali", messages: chats, wasRead: true),
  ChatModel(name: "mohamed belgacem", image: "https://ui-avatars.com/api/?mohamed+belgacem ", messages: chats, wasRead: true),
  ChatModel(name: "anis tounsi", image: "https://ui-avatars.com/api/?name=anis+tounsi ", messages: chats, wasRead: true),
  ChatModel(name: "ammar ali", image: "https://ui-avatars.com/api/?name=ammar+ali ", messages: chats, wasRead: true),
  ChatModel(name: "sami bouzaidi", image: "https://ui-avatars.com/api/?name=sami+bouzaidi ", messages: chats, wasRead: true),
  ChatModel(name: "rabie houssaini5", image: "https://ui-avatars.com/api/?name=Rabie+Houssaini ", messages: chats, wasRead: true),
  ChatModel(name: "rabie houssaini5", image: "https://ui-avatars.com/api/?name=Rabie+Houssaini ", messages: chats, wasRead: true),
];