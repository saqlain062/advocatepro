import 'package:advocatepro_f/Methods/toast.dart';
import 'package:advocatepro_f/screens/authenticate/forgot_password.dart';
import 'package:advocatepro_f/screens/authenticate/sign_up.dart';
import 'package:advocatepro_f/screens/home/home_screen.dart';
import 'package:advocatepro_f/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignIn extends StatefulWidget {
  static const String id = 'login';
  const SignIn({
    super.key,
  });

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final AuthService _auth = AuthService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  bool falled = false;
  bool boolLginSuccessful = false;
  String userType = "Lawyer";
  bool isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
  }

  void check() {
    setState(() {
      falled = true;
    });
  }

  void checkin() {
    setState(() {
      falled = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(
                        height: 100,
                        width: 100,
                        image: AssetImage('images/lawyerIcon.png')),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'AdvocatePro',
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                      label: const Text("Username"),
                      hintText: 'Username',
                      fillColor: const Color.fromARGB(255, 255, 255, 255),
                      filled: true,
                      prefixIcon: const Icon(
                        Icons.person_2_rounded,
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Color(0xffE4E7Eb)),
                          borderRadius: BorderRadius.circular(10)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Color(0xffE4E7Eb)))),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: passwordController,
                  obscureText: !isPasswordVisible,
                  decoration: InputDecoration(
                      labelText: "Password",
                      hintText: 'Password',
                      fillColor: const Color.fromARGB(255, 255, 255, 255),
                      filled: true,
                      prefixIcon: const Icon(Icons.lock_open),
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
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Color(0xffE4E7Eb))),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Color(0xffE4E7Eb)))),
                ),
// Forgot Password
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, ForgetPasswordScreen.id);
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            decoration: TextDecoration.underline,
                            color: Colors.blue),
                      ),
                    )
                  ]),
                ),
                const SizedBox(
                  height: 40,
                ),
                if (falled)
                  const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error,
                          color: Colors.red,
                        ),
                        Text('Try Again',
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold)),
                      ]),
//  Login Button
                TextButton(
                  onPressed: () async {
                    signIn();
                    // final email = emailController.text;
                    // final pass = passwordController.text;
                  },
                  child: Container(
                    height: 55,
                    width: 335,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 0, 110, 255),
                        borderRadius: BorderRadius.circular(30)),
                    child: Center(
                      child: boolLginSuccessful
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text('log In',
                              style: TextStyle(
                                  fontFamily: 'Rubik Regular',
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
// Sign with google
                TextButton(
                  onPressed: () async {
                    _signInWithGoogle();
                  },
                  child: Container(
                    height: 55,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(30)),
                    child: const Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesomeIcons.google,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text('Sign in with Google',
                              style: TextStyle(
                                  fontFamily: 'Rubik Regular',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                ),
// Sign Up Screen if you do not have account
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account?',
                      style: TextStyle(fontSize: 20),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, SignUpScreen.id);
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ))
                  ],
                )
              ],
            ),
          ),
        )),
      ),
    );
  }

// Methods for SignIn which call sign in with email and password massage form other file
  Future<String> signIn() async {
    setState(() {
      boolLginSuccessful = true;
    });
    // String f_name = controllerFirstName.text;
    String email = emailController.text;
    String password = passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    print("---------------------------");
    print(user);
    print("---------------------------");

    setState(() {
      boolLginSuccessful = false;
    });

    if (user != null) {
      String userUid = user.uid;

      showToast(message: "User is successfully SignIn");
      Navigator.pushNamed(context, HomeScreen.id);
      return userUid;
    } else {
      showToast(message: "Some error happend");
      return '';
    }
  }

  _signInWithGoogle() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        await _firebaseAuth.signInWithCredential(credential);
        Navigator.pushNamed(context, SignIn.id);
      }
    } catch (e) {
      showToast(message: "some error occured $e");
    }
  }
}
