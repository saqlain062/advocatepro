import 'package:advocatepro_f/Methods/share.dart';
import 'package:advocatepro_f/check_method.dart';
import 'package:advocatepro_f/screens/Forms/form_attribute.dart';
import 'package:advocatepro_f/screens/authenticate/sign_in.dart';
import 'package:advocatepro_f/screens/bottom/profile/profile_attribute.dart';
import 'package:advocatepro_f/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreenDesgine extends StatefulWidget {
  static const String id = 'home_screen_desgine';
  const HomeScreenDesgine({super.key});

  @override
  State<HomeScreenDesgine> createState() => _HomeScreenDesgineState();
}

class _HomeScreenDesgineState extends State<HomeScreenDesgine> {
  List<FormAttribute> userList = [];
  // List<Username> usernameList = [];
  // int userid = LogIn.userid;
  String username = 'Null';
  String email = 'Email';

  final dates = DateTime.now();
  bool internet = false;
  @override
  void initState() {
    super.initState();
  }

  bool isToday(String time) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day + 2);
    final format = dateformat(time);
    return format.isAtSameMomentAs(today);
  }

  void refreshpage() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HOME'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(onPressed: refreshpage, icon: const Icon(Icons.refresh))
        ],
      ),
      drawer: Drawer(
          child: FutureBuilder<List<ProfileAttribute>>(
              future: fetchDataOfCurrentUser(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error:${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text('No data available');
                } else {
                  // Get the user profile data
                  ProfileAttribute userProfile = snapshot.data!.first;
                  // Set the initial values for controllers
                  final fname = userProfile.object.fname;
                  final lname = userProfile.object.lname;
                  final gmail = userProfile.email;
                  return ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      UserAccountsDrawerHeader(
                          currentAccountPicture: const CircleAvatar(
                            backgroundImage:
                                AssetImage('images/lawyerIcon.png'),
                          ),
                          accountName: Text('$fname $lname'),
                          accountEmail: Text(gmail)),
                      ListTile(
                        leading: const Icon(Icons.home),
                        title: const Text('Home'),
                        onTap: () {
                          Navigator.pushNamed(context, HomeScreen.id);
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.edit),
                        title: const Text('Update Client Info'),
                        onTap: () {
                          Navigator.pushNamed(context, FormFields.id);
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.share),
                        title: const Text('Share'),
                        onTap: () {
                          shareApp();
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.logout),
                        title: const Text('Log out'),
                        onTap: () {
                          FirebaseAuth.instance.signOut();
                          Navigator.pushNamed(context, SignIn.id);
                        },
                      )
                    ],
                  );
                }
              })),
      body: SafeArea(
        child: Column(children: [
          if (internet) const InternetError(),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(5, 5),
                        blurRadius: 10,
                      )
                    ]),
                child: const Center(
                    child: Text(
                  'WELCOME',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ))),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 170,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0, 10),
                        blurRadius: 20,
                      )
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListView.builder(
                    itemCount: userList.length,
                    itemBuilder: (context, index) {
                      final rowData = userList[index];
                      final dates = isToday(rowData.previousDate);
                      if (dates) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 6, right: 6, top: 6, bottom: 4),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ListTile(
                              leading: const Image(
                                  height: 50,
                                  width: 50,
                                  image: AssetImage('images/lawyer.png')),
                              title: Text(rowData.name),
                              subtitle: Text(rowData.phone),
                              trailing: Text(date(rowData.nextAppearance)),
                            ),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 140.0),
                child: Container(
                  height: 100,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0, 10),
                        blurRadius: 20,
                      )
                    ],
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Center(
                      child: Text(
                    'Coming Soon!',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  )),
                ),
              )
            ],
          ),
        ]),
      ),
    );
  }
}
