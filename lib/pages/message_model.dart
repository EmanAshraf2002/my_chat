import 'package:cloud_firestore/cloud_firestore.dart';

class Message{
  final String message;
  final String id;
  final DateTime date;

  Message(this.message, this.id, this.date);
  factory Message.fromJson(jsonData){
    return Message(jsonData['message'],jsonData['id'],(jsonData['createdAt'] as Timestamp).toDate()
    );
  }

}