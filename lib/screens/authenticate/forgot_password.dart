import 'package:advocatepro_f/Methods/round_button.dart';
import 'package:advocatepro_f/Methods/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static const String id = 'forget_password';
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final contorlloremail = TextEditingController();
  final auth = FirebaseAuth.instance ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forget Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
        
          TextFormField(
            controller: contorlloremail,
            decoration: const InputDecoration(hintText: 'Email'),
          ),
          const SizedBox(
            height: 40,
          ),
          RoundButton(title: "Forgot Password",onTop: (){
            auth.sendPasswordResetEmail(email: contorlloremail.text.toString()).then((value){
              showToast(message: "We have sent you email to recover password, please check your password");

            }).onError((error, stackTrace){
            showToast(message: error.toString());
            }); 
          },),
          
          
        ]),
      ),
    );
  }
}
