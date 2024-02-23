import 'package:advocatepro_f/Methods/toast.dart';
import 'package:advocatepro_f/utils/validators/check_method.dart';
import 'package:advocatepro_f/screens/authenticate/sign_in.dart';
import 'package:advocatepro_f/screens/authenticate/sign_up_attribute.dart';
import 'package:advocatepro_f/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SignUpScreen extends StatefulWidget {
  static const String id = 'signup_screen';
  const SignUpScreen({
    super.key,
  });

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
  late TextEditingController controllerPassword = TextEditingController();
  late TextEditingController controllerLawyerID = TextEditingController();
  bool boolSignUpSuccessfull = false;
  bool isChecked = false;
  bool isPasswordVisible = false;
  String lawyerID = 'Null';

  final AuthService _auth = AuthService();
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  final DateFormat format = DateFormat('yyyy-MM-dd');
  late DateTime dateTime;

  // bool error = false;

  Future<void> calender(BuildContext context) async {
    final DateTime? dateTime = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900, 1, 1),
        lastDate: DateTime.now());
    if (dateTime != null) {
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
                          height: 200,
                          width: 200,
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
// First Name Field
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
// Second Name Field
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
                        height: 10,
                      ),
// check box
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Check box if You are a Lawyer',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Checkbox(
                              checkColor: Colors.white,
                              activeColor: Colors.pink,
                              value: isChecked,
                              onChanged: (value) {
                                setState(() {
                                  isChecked = value ?? false;
                                });
                              }),
                        ],
                      ),
                      if (isChecked)
                        TextFormField(
                            onChanged: (value) {
                              setState(() {
                                lawyerID = value;
                              });
                            },
                            controller: controllerLawyerID,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.person_pin_rounded),
                              labelText: 'Enter Your lawyer ID',
                              hintText: 'Enter Your lawyer ID',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(width: 4)),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              return checklist(value);
                            }),
                      const SizedBox(
                        height: 10,
                      ),

//Email Field
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
// Date of Birth field
                      // TextFormField(
                      //   readOnly: true,
                      //   onTap: () =>
                      //     calender(context),
                      //   controller: controllerDoB,
                      //   decoration: InputDecoration(
                      //       prefixIcon: const Icon(Icons.calendar_month),
                      //       label: const Text('DOB'),
                      //       hintText: 'Enter your Date of Birth',
                      //       border: OutlineInputBorder(
                      //           borderRadius: BorderRadius.circular(10),
                      //           borderSide: const BorderSide(width: 4))),
                      // validator: (value) =>
                      // value != null && value.isEmpty ? 'Enter DoB': null,
                      // ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
// Phone Number Field
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
                        validator: (value) {
                          return checknumber(value);
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
// Password Field
                      TextFormField(
                        controller: controllerPassword,
                        obscureText: !isPasswordVisible,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: Icon(isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  isPasswordVisible = !isPasswordVisible;
                                });
                              },
                            ),
                            label: const Text('Password'),
                            hintText: 'Enter your Password',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(width: 4))),
                        validator: (value) => value != null && value.isEmpty
                            ? 'Enter Password'
                            : null,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
//Signup Button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () async {
                              final form = _formkey.currentState!;
                              final isValid = form.validate();
                              if (isValid) {
                                signUp();
                              }
                            },
                            child: Container(
                              width: 335,
                              height: 55,
                              decoration: BoxDecoration(
                                  color: Colors.pink,
                                  borderRadius: BorderRadius.circular(50)),
                              child: Center(
                                  child: boolSignUpSuccessfull
                                      ? const CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                      : const Text(
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
                            // widget.toggleView();
                            Navigator.pushNamed(context, SignIn.id);
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

  void signUp() async {
    setState(() {
      boolSignUpSuccessfull = true;
    });
    // String f_name = controllerFirstName.text;
    String email = controllerEmail.text;
    String password = controllerPassword.text;

    User? user = await _auth.signUpWithEmailAndPassword(email, password);
    // Access the user UID after a successful sign-up
    // String userUid = user!.uid;
    _insertSignupData();
    controllerFirstName.clear;
    controllerLawyerID.clear;
    controllerPassword.clear;
    controllerSecondName.clear;
    controllerphone.clear;
    controllerEmail.clear;

    setState(() {
      boolSignUpSuccessfull = false;
    });

    if (user != null) {
      showToast(message: "User is successfully created");
      Navigator.pushNamed(context, SignIn.id);
    } else {
      showToast(message: "Some error happend");
    }
  }

  void _insertSignupData() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    print("------------------------");
    print(uid);
    if (lawyerID == 'Null') {
      
      final userCollection = FirebaseFirestore.instance.collection("users");
      final newUser = SignupAttribute(
        id: uid,
        fname: controllerFirstName.text,
        lname: controllerSecondName.text,
        phone: controllerPassword.text,
        email: controllerEmail.text,
        laywerOrNot: controllerLawyerID.text,
        specialization: lawyerID,
        dateofbirth: lawyerID,
      ).toJson();
      userCollection.doc(uid).set(newUser);
      print(newUser);
      print(userCollection);
    } else {
      final userCollection = FirebaseFirestore.instance.collection("lawyers");
      final newUser = SignupAttribute(
        id: uid,
        fname: controllerFirstName.text,
        lname: controllerSecondName.text,
        phone: controllerphone.text,
        pass: controllerPassword.text,
        email: controllerEmail.text,
        laywerOrNot: lawyerID,
        specialization: lawyerID,
        dateofbirth: lawyerID,
      ).toJson();
      userCollection.doc(uid).set(newUser);
    }
  }
}
