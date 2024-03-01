import 'package:advocatepro_f/Methods/toast.dart';
import 'package:advocatepro_f/common/widgets/login_signup/form_divider.dart';
import 'package:advocatepro_f/features/authenticate/screens/signup/widgets/signup_form.dart';
import 'package:advocatepro_f/utils/constants/color.dart';
import 'package:advocatepro_f/utils/constants/image_strings.dart';
import 'package:advocatepro_f/utils/constants/sizes.dart';
import 'package:advocatepro_f/utils/constants/text_strings.dart';
import 'package:advocatepro_f/features/authenticate/screens/signin/sign_in.dart';
import 'package:advocatepro_f/features/authenticate/screens/signup/sign_up_attribute.dart';
import 'package:advocatepro_f/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  late TextEditingController controllerFirstName = TextEditingController();
  late TextEditingController controllerEmail = TextEditingController();
  late TextEditingController controllerphone = TextEditingController();
  late TextEditingController controllerSecondName = TextEditingController();
  late TextEditingController controllerDoB = TextEditingController();
  late TextEditingController controllerPassword = TextEditingController();
  late TextEditingController controllerLawyerID = TextEditingController();
  bool boolSignUpSuccessfull = false;
  bool isChecked = false;
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
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: SColors.primary),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SSizes.defaultSpaces),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title
              const Image(height: 70, image: AssetImage(SImages.lightAppLogo)),
              Text(
                STexts.signupTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: SSizes.spaceBetweenSections,
              ),

              /// Form
              const SSignupForm(),
              const SizedBox(
                height: SSizes.spaceBetweenItems,
              ),

              /// Divider
              SFormDivider(dividerText: STexts.orSignUpWith.capitalize!),
              const SizedBox(
                height: SSizes.spaceBetweenItems,
              ),
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
