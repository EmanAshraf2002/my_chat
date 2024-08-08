import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_chat_app/constants.dart';
import 'package:my_chat_app/pages/message_model.dart';

class ChatBuble extends StatelessWidget {
  const ChatBuble({
    super.key, required this.message_obj,
  });
 final Message message_obj;
  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('hh:mm a').format(message_obj.date);
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin:const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
        padding:const EdgeInsets.only(left: 16,right: 16,top: 32,bottom: 32),
        decoration:const  BoxDecoration(
          color: kPrimaryColor ,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32) ,
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
        ),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(message_obj.message,
              style:const TextStyle(
                color: Colors.white ,
              ) ,
            ),
          const SizedBox(height: 8),
          Text(formattedDate,
          textAlign:TextAlign.right,
          style:const TextStyle(
            fontSize: 10,
            color: Colors.white ,)
          ),
          ],
        ),
      ),
    );
  }
}

class ChatBubleForFriend extends StatelessWidget {
  const ChatBubleForFriend({
    super.key, required this.message_obj,
  });
  final Message message_obj;
  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('hh:mm a').format(message_obj.date);
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin:const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
        padding:const EdgeInsets.only(left: 16,right: 16,top: 32,bottom: 32),
        decoration:const  BoxDecoration(
          color: friendChatColor ,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32) ,
            topRight: Radius.circular(32),
            bottomLeft: Radius.circular(32),
          ),
        ),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(message_obj.message,
              style:const TextStyle(
                color: Colors.black ,
              ) ,
            ),
            const SizedBox(height: 8),
            Text(formattedDate,
                textAlign:TextAlign.right,
                style:const TextStyle(
                  fontSize: 10,
                  color: Colors.black,)
            ),
          ],
        ),
      ),
    );
  }
}