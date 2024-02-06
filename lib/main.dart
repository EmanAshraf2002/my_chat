import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_chat_app/pages/chat_page.dart';
import 'package:my_chat_app/pages/login_page.dart';
import 'package:my_chat_app/pages/register_page.dart';
import 'package:my_chat_app/pages/splash_page.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        'LoginPage' : (context) => LoginPage()  ,
        'RegisterPage' : (context) => RegisterPage() ,
        'SplashScreen' : (context) =>const SplashScreen() ,
        ChatPage.id : (context) =>ChatPage() ,
      },
      initialRoute: 'SplashScreen' ,

    );
  }
}
