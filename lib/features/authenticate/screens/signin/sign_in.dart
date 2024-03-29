import 'package:advocatepro_f/common/styles/spacing_styles.dart';
import 'package:advocatepro_f/common/widgets/login_signup/form_divider.dart';
import 'package:advocatepro_f/common/widgets/login_signup/social_buttons.dart';
import 'package:advocatepro_f/features/authenticate/screens/signin/widgets/sign_in_form.dart';
import 'package:advocatepro_f/features/authenticate/screens/signin/widgets/sign_in_header.dart';
import 'package:advocatepro_f/utils/constants/sizes.dart';
import 'package:advocatepro_f/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignIn extends StatelessWidget {
  static const String id = 'login';
  const SignIn({
    super.key,
  });

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
              const SigninForm(),

              /// Divider
              SFormDivider(dividerText: STexts.orSignInWith.capitalize!,),
              const SizedBox(
                height: SSizes.spaceBetweenSections,
              ),

              // Footer
              const SSocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}

// Methods for SignIn which call sign in with email and password massage form other file
//   void signIn() async {
//     setState(() {
//       boolLginSuccessful = true;
//     });
//     // String f_name = controllerFirstName.text;
//     String email = emailController.text;
//     String password = passwordController.text;

//     User? user = await _auth.signInWithEmailAndPassword(email, password);

//     print("-----------User Detial----------------");
//     print(user);
//     print("-------------End User Detail--------------");

//     setState(() {
//       boolLginSuccessful = false;
//     });
//     if (user != null) {
//       final userCollection = FirebaseFirestore.instance.collection("users");

//       // Check if the user already exists in Firestore
//       final userDocument = await userCollection.doc(user.uid).get();
//       if (userDocument.exists) {
//         showToast(message: "User is successfully SignIn");
//         Navigator.pushNamed(context, ClientHomeScreen.id);
//       } else {
//         final lawyerCollection =
//             FirebaseFirestore.instance.collection("lawyers");
//         // Check if the user already exists in Firestore
//         final lawyerDocument = await lawyerCollection.doc(user.uid).get();
//         if (lawyerDocument.exists) {
//           showToast(message: "User is successfully SignIn");
//           Navigator.pushNamed(context, LawyerNavigationMenu.id);
//         }
//       }
//     } else {
//       showToast(message: "Some error happend");
//     }
//   }

//   _signInWithGoogle() async {
//     setState(() {
//       LginSuccessful = true;
//     });
//     final GoogleSignIn _googleSignIn = GoogleSignIn();

//     // Sign out the user from any previously signed-in Google accounts
//     await _googleSignIn.signOut();

//     try {
//       final GoogleSignInAccount? googleSignInAccount =
//           await _googleSignIn.signIn();

//       if (googleSignInAccount != null) {
//         final GoogleSignInAuthentication googleSignInAuthentication =
//             await googleSignInAccount.authentication;

//         final AuthCredential credential = GoogleAuthProvider.credential(
//           idToken: googleSignInAuthentication.idToken,
//           accessToken: googleSignInAuthentication.accessToken,
//         );

//         await _firebaseAuth.signInWithCredential(credential);
//         // Access the signed-in user's information
//         final user = _firebaseAuth.currentUser;
//         print('-----------------$user');
//         // Store user data in Firestore
//         if (user != null) {
//           final userCollection = FirebaseFirestore.instance.collection("users");
//           // Check if the user already exists in Firestore
//           final userDocument = await userCollection.doc(user.uid).get();

//           final lawyerCollection =
//               FirebaseFirestore.instance.collection("lawyers");
//           // Check if the user already exists in Firestore
//           final lawyerDocument = await lawyerCollection.doc(user.uid).get();
//           if (userDocument.exists) {
//             setState(() {
//               LginSuccessful = false;
//             });
//             Navigator.pushNamed(context, ClientHomeScreen.id);
//           } else if (lawyerDocument.exists) {
//             setState(() {
//               LginSuccessful = false;
//             });
//             Navigator.pushNamed(context, LawyerNavigationMenu.id);
//           } else {
//             setState(() {
//               LginSuccessful = false;
//             });
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => const LawyerOrUserScreen()));
//           }
//         }
//       }
//     } catch (e) {
//       showToast(message: "some error occured $e");
//     }
//   }

//   void getValue() async {
//     var perfs = await SharedPreferences.getInstance();
//     var emailValue = perfs.getString("email");
//     var passwordValue = perfs.getString("password");
//     setState(() {
//       emailController.text = emailValue ?? "";
//       passwordController.text = passwordValue ?? "";
//     });
//   }



