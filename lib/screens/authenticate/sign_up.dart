import 'package:advocatepro_f/check_method.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SignUpScreen extends StatefulWidget {
  static const String id = 'signup_screen';
  final Function toggleView;
  const SignUpScreen({super.key,
  required this.toggleView});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formkey = GlobalKey<FormState>();
  late TextEditingController controllerFirstName = TextEditingController();
  late TextEditingController controllerEmail = TextEditingController();  
  late TextEditingController controllerphone = TextEditingController();  
  late TextEditingController controllerSecondName = TextEditingController();
  late TextEditingController controllerDoB = TextEditingController();
  // late TextEditingController controllerConfirmPassword = TextEditingController();
  final DateFormat format = DateFormat('yyyy-MM-dd');
  late DateTime dateTime;

  // bool error = false;

  Future <void> calender(BuildContext context) async{
  final DateTime? dateTime = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1900,1,1),
    lastDate: DateTime.now());
    if(dateTime != null ){
      setState(() {
        controllerDoB.text = format.format(dateTime);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formkey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
                      const Image(
                          height: 100,
                          width: 100,
                          image: AssetImage('images/lawyer.png')),
                      const Center(
                          child: Text(
                        'Create Account',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      )),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: controllerFirstName,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.person),
                                  label: const Text('First Name'),
                                  hintText: 'Enter your first name',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(width: 4))),
                              validator: (value) {
                                return checkname(value);
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: controllerSecondName,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.person),
                                  label: const Text('Second Name'),
                                  hintText: 'Enter your Second Name',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(width: 4))),
                              validator: (value) {
                                return checkname(value);
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: controllerEmail,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.email),
                            label: const Text('Email'),
                            hintText: 'Enter your email',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(width: 4))),
                        validator: (value) {
                          return checkEmail(value);
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        readOnly: true,
                        onTap: () =>
                          calender(context),
                        controller: controllerDoB,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.calendar_month),
                            label: const Text('DOB'),
                            hintText: 'Enter your Date of Birth',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(width: 4))),
                      validator: (value) =>
                      value != null && value.isEmpty ? 'Enter DoB': null,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: controllerphone,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.phone),
                            label: const Text('Phone'),
                            hintText: '0300-1234567',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(width: 4))),
                      validator:(value) {
                        return checknumber(value);
                      },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // TextFormField(
                      //   controller: controllerConfirmPassword,
                      //   decoration: InputDecoration(
                      //       prefixIcon: const Icon(Icons.lock),
                      //       label: const Text('Confirm Password'),
                      //       hintText: 'Enter your Confirm Password',
                      //       border: OutlineInputBorder(
                      //           borderRadius: BorderRadius.circular(10),
                      //           borderSide: const BorderSide(width: 4))),
                      //   validator: (value) => value != null && value.isEmpty
                      //       ? 'Enter Confirm Password'
                      //       : null,
                      // ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      // if (error)
                      //   const Text(
                      //     'Check Password',
                      //     style: TextStyle(color: Colors.red),
                      //   ),
//Signup Button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton( 
                            onPressed: () async {
                              final form = _formkey.currentState!;
                              final isValid = form.validate();
                              if (isValid) {
                                // final pass = controllerpassword.text;
                                // final confirmPass = controllerConfirmPassword.text;
                                // if (pass == confirmPass) {
                                  
                                
                                  
                                  // Future.delayed(Duration.zero, () {
                                  //   Navigator.pushNamed(context, UserScreen.id);
                                  // }
                                  // );
                                } 
                                // else {
                                //   setState(() {
                                //     error = true;
                                //   });
                                // }
                              // }
                            },
                            child: Container(
                              width: 335,
                              height: 55,
                              decoration: BoxDecoration(
                                color: Colors.pink,
                                borderRadius: BorderRadius.circular(50)),
                              child: const Center(
                                child: Text(
                                  'Sign up',
                                  style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Colors.white,
                                ),
                              )),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
//Already have account switch between sign in and sign up
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have a Account?',
                        style: TextStyle(fontSize: 20),
                      ),
                      TextButton(
                          onPressed: () {
                            widget.toggleView();
                            // Navigator.pushNamed(context, LogIn.id);
                          },
                          child: const Text(
                            'Sign in',
                            style: TextStyle(color: Colors.pink, fontSize: 20),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}
