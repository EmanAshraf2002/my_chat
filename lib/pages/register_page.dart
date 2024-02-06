
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:my_chat_app/constants.dart';
import 'package:my_chat_app/widgets/custom_button.dart';
import 'package:my_chat_app/widgets/custom_textField.dart';

import '../helper/ShowSnakBar.dart';
import 'package:my_chat_app/pages/chat_page.dart';

class RegisterPage extends StatefulWidget{
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? email ;
  String? password ;

  bool isLoading=false;

 GlobalKey<FormState> formKey=GlobalKey();

  @override
  Widget build(BuildContext context) {

    return ModalProgressHUD(
      inAsyncCall:isLoading ,
      child: Scaffold(
        backgroundColor:kPrimaryColor ,
        body:Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 50,) ,
                  const CircleAvatar(radius:70,
                    backgroundImage:AssetImage('assets/img_1.png'),
                  ),
                  const Text('Scholar Chat ' ,
                    style:TextStyle(
                      color: Colors.white ,
                      fontSize: 26 ,
                      fontFamily:'customFont' ,
                    ) ,
                  ),
                  const SizedBox(height: 70,) ,
                  const Row(
                    children: [
                      Text('REGISTER' ,
                        style:TextStyle(
                          color: Colors.white ,
                          fontSize: 22 ,
                        ) ,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16,),
                  CustomTextFormField(
                      onChanged: (data){
                        email=data;
                      },
                      hintText: 'Enter your email ',
                      labelText:'Email') ,
                  const SizedBox(height: 10,),
                  CustomTextFormField(
                      onChanged: (data){
                        password=data;
                      },
                      hintText: 'Enter password ',
                      labelText:'Password',
                    passObscureText: true,
                   ) ,
                  const SizedBox(height: 22 ,),
                  CustomButton(buttonText: 'register',
                     onTap: () async{
                    if (formKey.currentState!.validate()) {
                       isLoading=true ;
                       setState(() { });
                      try {
                        await registerUser();
                        Navigator.pushNamed(context,ChatPage.id , arguments: email);
                      }
                      on FirebaseAuthException catch (ex) {
                        if (ex.code == 'weak-password') {
                          showSnackBar(context,'weak password ,try again');
                        } else if (ex.code == 'email-already-in-use') {
                          showSnackBar(context, 'email already exsist');
                        }
                      }
                      catch(e){
                        showSnackBar(context,'There was an error');
                      }
                      isLoading=false;
                      setState(() { });

                    }
                    else{}

                     },
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?" ,
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child:const Text('login',
                          style: TextStyle(
                              color:Color(0xffC7EDE6)
                          ),
                        ),
                      ),
                    ],

                  ),

                  const SizedBox(height: 70,) ,
                ],

              ),
            ),
          ),
        ),

      ),
    );


  }


  Future<void> registerUser() async {
    var auth= FirebaseAuth.instance;
    UserCredential user =
    await auth.createUserWithEmailAndPassword(email: email!, password: password!);
  }
}