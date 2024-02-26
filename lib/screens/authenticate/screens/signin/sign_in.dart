import 'package:advocatepro_f/Methods/toast.dart';
import 'package:advocatepro_f/common/styles/spacing_styles.dart';
import 'package:advocatepro_f/common/widgets/login_signup/form_divider.dart';
import 'package:advocatepro_f/utils/constants/color.dart';
import 'package:advocatepro_f/screens/authenticate/screens/password_configuration/forgot_password.dart';
import 'package:advocatepro_f/screens/authenticate/lawyer_or_user.dart';
import 'package:advocatepro_f/screens/authenticate/screens/signup/sign_up.dart';
import 'package:advocatepro_f/screens/home/home_client_screen.dart';
import 'package:advocatepro_f/screens/home/home_screen.dart';
import 'package:advocatepro_f/services/auth.dart';
import 'package:advocatepro_f/utils/constants/image_strings.dart';
import 'package:advocatepro_f/utils/constants/sizes.dart';
import 'package:advocatepro_f/utils/constants/text_strings.dart';
import 'package:advocatepro_f/utils/helpers/helper_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  static const String id = 'login';
  const SignIn({
    super.key,
  });

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  final AuthService _auth = AuthService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  bool falled = false;
  bool boolLginSuccessful = false;
  String userType = "Lawyer";
  bool isPasswordVisible = false;
  bool LginSuccessful = false;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    getValue();
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
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: SSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Logo, Title & Sub-Title
              const SLoginHeader(),

              /// Form
              Form(
                  child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: SSizes.spaceBetweenSections),
                child: Column(
                  children: [
                    /// Email
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: STexts.email,
                        hintText: STexts.email,
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: SColors.iconColor,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: SSizes.spaceBtwInputFields,
                    ),

                    /// Password
                    TextFormField(
                      controller: passwordController,
                      obscureText: !isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: STexts.password,
                        hintText: STexts.password,
                        prefixIcon: const Icon(Icons.lock_open),
                        suffixIcon: IconButton(
                          icon: Icon(isPasswordVisible
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined),
                          onPressed: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: SSizes.spaceBtwInputFields / 2,
                    ),

                    // Remember Me & Forgot Password
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          /// Remember Me
                          Row(
                            children: [
                              Checkbox(value: true, onChanged: (onChanged) {}),
                              const Text(STexts.rememberMe),
                            ],
                          ),

                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, ForgetPasswordScreen.id);
                            },
                            child: const Text(
                              STexts.forgetPassword,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  // decoration: TextDecoration.underline,
                                  color: Colors.blue),
                            ),
                          )
                        ]),
                    const SizedBox(
                      height: SSizes.spaceBetweenSections,
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
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          var perfs = await SharedPreferences.getInstance();
                          perfs.setString("email", emailController.text);
                          perfs.setString("password", passwordController.text);
                          signIn();
                        },
                        child: Center(
                          child: boolLginSuccessful
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(STexts.signIn),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: SSizes.spaceBetweenItems,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () => Get.to(() => const SignUpScreen()),
                        child: const Text(STexts.createAccount),
                      ),
                    ),
                  ],
                ),
              )),

              /// Divider
              SFormDivider(dividerText: STexts.orSignInWith.capitalize!,),
              const SizedBox(
                height: SSizes.spaceBetweenSections,
              ),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    _signInWithGoogle();
                  },
                  child: Center(
                    child: LginSuccessful
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.google,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Sign In with Google',
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// Methods for SignIn which call sign in with email and password massage form other file
  void signIn() async {
    setState(() {
      boolLginSuccessful = true;
    });
    // String f_name = controllerFirstName.text;
    String email = emailController.text;
    String password = passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    print("-----------User Detial----------------");
    print(user);
    print("-------------End User Detail--------------");

    setState(() {
      boolLginSuccessful = false;
    });
    if (user != null) {
      final userCollection = FirebaseFirestore.instance.collection("users");

      // Check if the user already exists in Firestore
      final userDocument = await userCollection.doc(user.uid).get();
      if (userDocument.exists) {
        showToast(message: "User is successfully SignIn");
        Navigator.pushNamed(context, ClientHomeScreen.id);
      } else {
        final lawyerCollection =
            FirebaseFirestore.instance.collection("lawyers");
        // Check if the user already exists in Firestore
        final lawyerDocument = await lawyerCollection.doc(user.uid).get();
        if (lawyerDocument.exists) {
          showToast(message: "User is successfully SignIn");
          Navigator.pushNamed(context, HomeScreen.id);
        }
      }
    } else {
      showToast(message: "Some error happend");
    }
  }

  _signInWithGoogle() async {
    setState(() {
      LginSuccessful = true;
    });
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    // Sign out the user from any previously signed-in Google accounts
    await _googleSignIn.signOut();

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
        // Access the signed-in user's information
        final user = _firebaseAuth.currentUser;
        print('-----------------$user');
        // Store user data in Firestore
        if (user != null) {
          final userCollection = FirebaseFirestore.instance.collection("users");
          // Check if the user already exists in Firestore
          final userDocument = await userCollection.doc(user.uid).get();

          final lawyerCollection =
              FirebaseFirestore.instance.collection("lawyers");
          // Check if the user already exists in Firestore
          final lawyerDocument = await lawyerCollection.doc(user.uid).get();
          if (userDocument.exists) {
            setState(() {
              LginSuccessful = false;
            });
            Navigator.pushNamed(context, ClientHomeScreen.id);
          } else if (lawyerDocument.exists) {
            setState(() {
              LginSuccessful = false;
            });
            Navigator.pushNamed(context, HomeScreen.id);
          } else {
            setState(() {
              LginSuccessful = false;
            });
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const LawyerOrUserScreen()));
          }
        }
      }
    } catch (e) {
      showToast(message: "some error occured $e");
    }
  }

  void getValue() async {
    var perfs = await SharedPreferences.getInstance();
    var emailValue = perfs.getString("email");
    var passwordValue = perfs.getString("password");
    setState(() {
      emailController.text = emailValue ?? "";
      passwordController.text = passwordValue ?? "";
    });
  }
}



class SLoginHeader extends StatelessWidget {
  const SLoginHeader({
    super.key,
  });
  

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
            height: 150,
            image: AssetImage(
                dark ? SImages.lightAppLogo : SImages.darkAppLogo)),
        Text(
          STexts.loginTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(
          height: SSizes.smallmedium,
        ),
        Text(
          STexts.lgoinSubTitle,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
