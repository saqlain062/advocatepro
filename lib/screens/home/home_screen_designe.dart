import 'package:advocatepro_f/Methods/share.dart';
import 'package:advocatepro_f/check_method.dart';
import 'package:advocatepro_f/utils/constants/color.dart';
import 'package:advocatepro_f/screens/Forms/form_attribute.dart';
import 'package:advocatepro_f/screens/authenticate/sign_in.dart';
import 'package:advocatepro_f/screens/authenticate/sign_up_attribute.dart';
import 'package:advocatepro_f/screens/bottom/profile/profile_attribute.dart';
import 'package:advocatepro_f/screens/bottom/profile/support/supportscreen/feedback_screen.dart';
import 'package:advocatepro_f/screens/home/add_post_screen.dart';
import 'package:advocatepro_f/screens/home/case/case_screen.dart';
import 'package:advocatepro_f/screens/home/home_client_post_screen.dart';
import 'package:advocatepro_f/screens/home/home_screen.dart';
import 'package:advocatepro_f/screens/home/notification/notification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class HomeScreenDesgine extends StatefulWidget {
  static const String id = 'home_screen_desgine';
  const HomeScreenDesgine({super.key});

  @override
  State<HomeScreenDesgine> createState() => _HomeScreenDesgineState();
}

class _HomeScreenDesgineState extends State<HomeScreenDesgine> {
  TextEditingController controllersearch = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorbackground,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: colorAppbarText),
        centerTitle: true,
        backgroundColor: colorAppbar,
        title: const Text(
          'AdvocatePro',
          style: TextStyle(color: colorAppbarText),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NotificationScreen()));
            },
          ),
        ],
      ),
      drawer: Drawer(
          backgroundColor: Colors.white,
          child: FutureBuilder<List<SignupAttribute>>(
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
                  SignupAttribute userProfile = snapshot.data!.first;
                  // Set the initial values for controllers
                  final fname = userProfile.fname;
                  final lname = userProfile.lname;
                  final gmail = userProfile.email;
                  return ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      UserAccountsDrawerHeader(
                        currentAccountPicture: FirebaseAnimatedList(
                          query: FirebaseDatabase.instance
                              .ref('Post_${uid()}_profile'),
                          itemBuilder: (context, snapshots, animation, index) {
                            final imageUrl =
                                snapshots.child('url').value.toString();
                            return CircleAvatar(
                                child: imageUrl.isNotEmpty
                                    ? Image.network(
                                        imageUrl,
                                     
                                      )
                                    : const CircularProgressIndicator());
                          }),
                        
                        accountName: Text('$fname $lname'),
                        accountEmail: Text(gmail),
                        decoration: const BoxDecoration(
                          color: colorAppbar,
                        ),
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.home,
                          color: colorIcon,
                        ),
                        title: const Text('Home'),
                        onTap: () {
                          Navigator.pushNamed(context, HomeScreen.id);
                        },
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.share,
                          color: colorIcon,
                        ),
                        title: const Text('Share'),
                        onTap: () {
                          shareApp();
                        },
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.logout,
                          color: colorIcon,
                        ),
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: colorAppbar,
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 15, left: 15, top: 10, bottom: 20),
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0xFF000000),
                          offset: Offset(1, 1),
                          blurRadius: 1,
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
                                border:
                                    Border.all(color: colorBorder, width: 1),
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
              ),

              const SizedBox(height: 20),
              //for search bar
              //         Container(
              //   padding: const EdgeInsets.all(8.0),
              //   child: TextField(
              //     controller: controllersearch,
              //     decoration: InputDecoration(
              //       hintText: 'Search...',
              //       prefixIcon: const Icon(Icons.search),
              //       border: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(10.0),
              //       ),
              //     ),
              //     onChanged: (value) {
              //       // Perform search operation based on the value entered in the search bar
              //       // You can use this value to filter your data or perform any other search-related tasks
              //     },
              //   ),
              // ),

              Row(// Row before More with advocatepro
                children: [
                  _card(
                      title: 'Add Post',
                      description: 'Null',
                      icon: Icons.add_comment_outlined,
                      screen: const AddPostScreen()),
                  _card(
                      title: 'Cases',
                      description: 'Null',
                      icon: Icons.cases_outlined,
                      screen: const CaseManagementScreen()),
                  _card(
                      title: 'Client',
                      description: 'Null',
                      icon: Icons.group_add_outlined,
                      screen: const CaseManagementScreen()),
                ],
              ),
              const SizedBox(height: 15),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  'More with advocatepro',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15, top: 10, bottom: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: colorWhite,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          _container(
                              title: 'option',
                              icon: Icons.access_alarm_outlined,
                              screen: const NotificationScreen()),
                          _container(
                              title: 'option',
                              icon: Icons.ac_unit,
                              screen: const NotificationScreen()),
                          _container(
                              title: 'option',
                              icon: Icons.pageview_outlined,
                              screen: const NotificationScreen()),
                          _container(
                              title: 'option',
                              icon: Icons.account_balance_outlined,
                              screen: const NotificationScreen()),
                        ],
                      ),
                      Row(
                        children: [
                          _container(
                              title: 'option',
                              icon: Icons.palette_outlined,
                              screen: const NotificationScreen()),
                          _container(
                              title: 'option',
                              icon: Icons.qr_code,
                              screen: const NotificationScreen()),
                          _container(
                              title: 'option',
                              icon: Icons.wallet_giftcard,
                              screen: const NotificationScreen()),
                          _container(
                              title: 'option',
                              icon: Icons.earbuds,
                              screen: const NotificationScreen()),
                        ],
                      ),
                      Row(
                        children: [
                          _container(
                              title: 'option',
                              icon: Icons.radar_outlined,
                              screen: const NotificationScreen()),
                          _container(
                              title: 'option',
                              icon: Icons.tab_outlined,
                              screen: const NotificationScreen()),
                          _container(
                              title: 'option',
                              icon: Icons.yard_outlined,
                              screen: const NotificationScreen()),
                          _container(
                              title: 'option',
                              icon: Icons.u_turn_left_sharp,
                              screen: const NotificationScreen()),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              _homeCard(
                title: 'Help & Customer Support',
                description:
                    "Register a complaint or get quick help on queries related to AdvocatePro",
                icon: Icons.support_agent_outlined,
                screen: const FeedbackScreen(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _card({
    required String title,
    required String description,
    required IconData icon,
    required Widget screen,
  }) {
    return Container(
      color: colorbackground,
      width: 130,
      height: 130, // Adjust the height of the container as needed
      child: Card(
        margin: const EdgeInsets.all(15.0),
        elevation: 10.0,
        surfaceTintColor: colorWhite,
        shadowColor: Colors.white,
        child: InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => screen));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 30,
                color: colorIcon,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _container({
    required String title,
    required IconData icon,
    required Widget screen,
  }) {
    return Card(
      margin: const EdgeInsets.all(20.0),
      elevation: 0,
      surfaceTintColor: colorWhite,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => screen));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 30,
              color: colorIcon,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _homeCard({
    required String title,
    required String description,
    required IconData icon,
    required screen,
  }) {
    return Card(
        margin: const EdgeInsets.all(8.0),
        elevation: 2.0,
        surfaceTintColor: colorWhite,
        child: InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => screen));
          },
          child: Column(
            children: [
              ListTile(
                leading: Icon(
                  icon,
                  size: 40,
                  color: colorIcon,
                ),
                title: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                subtitle: Text(
                  description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    controllersearch.dispose();
    super.dispose();
  }
}
