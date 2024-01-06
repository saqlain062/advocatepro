import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  //static const String id = 'login';
  final Function toggleView;
  
  const SignIn({super.key,
  required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool falled = false;
  bool loginSuccessful = false;
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
            padding: const EdgeInsets.only(left: 30,right: 30),
            child: Column(
              children: [
                const SizedBox(height: 50,),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(
                        height: 100,
                        width: 100,
                        image: AssetImage('images/lawyerIcon.png')),
                    SizedBox(width: 10,),
                    Text(
                      'AdvocatePro',
                      style: TextStyle(
                          fontSize: 40, fontWeight: FontWeight.bold),
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
                      suffixIcon: IconButton(icon:Icon( isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                      onPressed: (){
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      } ,),   
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Color(0xffE4E7Eb))),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Color(0xffE4E7Eb)))),
                  ),
                const Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Text(
                      'Forgot Password?',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          decoration: TextDecoration.underline,
                          color: Colors.blue),
                    ),
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
                                color: Colors.red, fontWeight: FontWeight.bold)),
                      ]),
                TextButton(
                  onPressed: () async {
                    // final email = emailController.text;
                    // final pass = passwordController.text;
                  },
                  child: Container(
                    height: 55,
                    width: 335,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 0, 110, 255),
                        borderRadius: BorderRadius.circular(30)),
                    child: const Center(
                      child: Text('log In',
                          style: TextStyle(
                              fontFamily: 'Rubik Regular',
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                  ),
                ),
// Sign Up Screen if you do not have account 
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don\'t have an account?',style: TextStyle(fontSize: 20),),
                    TextButton(
                        onPressed: () {
                          widget.toggleView();
                          //Navigator.pushNamed(context, SignUpScreen.id);
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold,fontSize: 20),
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
}
