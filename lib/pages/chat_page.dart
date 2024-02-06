import 'package:flutter/material.dart';
import 'package:my_chat_app/constants.dart';
import 'package:my_chat_app/pages/message_model.dart';
import 'package:my_chat_app/widgets/chat_buble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../helper/ShowSnakBar.dart';

class ChatPage extends StatelessWidget{
  ChatPage({super.key});
  static String id='ChatPage';

  CollectionReference messages= FirebaseFirestore.instance.collection('messages');
  TextEditingController myController=TextEditingController();
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
   var email= ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy('createdAt',descending: true).snapshots(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            List<Message> messageList=[];
            for(int i=0 ; i<snapshot.data!.docs.length ;i++)
            {
              messageList.add(Message.fromJson(snapshot.data!.docs[i]));
            }
            return Scaffold(
              appBar: AppBar(
                backgroundColor:kPrimaryColor ,
                centerTitle: true,
                //automaticallyImplyLeading: false,
                title:const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(radius:25,
                      backgroundImage:AssetImage('assets/img_1.png'),
                    ),
                    Text(' Chat'),
                  ],
                ),

              ),
              body:Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration:const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/chat_background.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: ListView.builder(
                          reverse: true,
                          controller: _controller ,
                          itemCount: messageList.length,
                          itemBuilder:(context,index){
                            return messageList[index].id==email ?
                            ChatBuble(message_obj: messageList[index],):
                            ChatBubleForFriend(message_obj: messageList[index],);
                          }),
                    ),
                  ),
                  Padding(
                    padding:const EdgeInsets.all(10),
                    child: TextField(
                      controller: myController,
                      onSubmitted: (data){
                        messages.add({
                          'message' : data ,
                          'id' :email ,
                          'createdAt':DateTime.now() ,
                        });
                        myController.clear();
                        _controller.animateTo(0,
                            duration:const Duration(milliseconds: 500),
                            curve: Curves.fastOutSlowIn);
                      },
                      decoration: InputDecoration(
                        suffixIcon:const Icon(Icons.send ,color: kPrimaryColor,),
                        hintText:'Send Message',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  )
                ],
              ) ,

            ) ;
          }
          else{
            return Container(
              height:double.infinity,
              width:double.infinity,
              color: Colors.white,
              child: const Center(
                child: CircularProgressIndicator(),
              )
            );

          }
        }
    ) ;
  }

}