
import 'package:advocatepro_f/features/lawyer/screen/homeScreen/add_detail/add_detail_screen.dart';
import 'package:advocatepro_f/utils/validators/check_method.dart';
import 'package:advocatepro_f/utils/constants/color.dart';
import 'package:advocatepro_f/features/Forms/form_attribute.dart';

import 'package:advocatepro_f/features/bottom/profile/support/supportscreen/feedback_screen.dart';
import 'package:advocatepro_f/features/home/add_post_screen.dart';
import 'package:advocatepro_f/features/home/case/case_screen.dart';
import 'package:advocatepro_f/features/home/home_client_post_screen.dart';

import 'package:advocatepro_f/features/home/notification/notification.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'widgets/home_drawer.dart';

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
    getImageUrl();
  }

  bool isToday(String time) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day + 2);
    final format = dateformat(time);
    return format.isAtSameMomentAs(today);
  }

  String imageUrl = '';

  Future<void> getImageUrl() async {
    try {
      final storage = FirebaseStorage.instance;
      final reff =
          storage.ref().child('users/${uid()}/Saqlain_profile_photo.jpg');
      final url = await reff.getDownloadURL();
      setState(() {
        imageUrl = url;
      });
    } catch (e) {
      print('Error getting image URL: $e');
      // You can set a default image URL or take other appropriate actions
      setState(() {
        imageUrl = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
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
      drawer: SHomeScreenDrawer(imageUrl: imageUrl),
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

              Row(
                // Row before More with advocatepro
                children: [
                  _card(
                      title: 'Add Post',
                      description: 'Null',
                      icon: Icons.add_comment_outlined,
                      screen: const AddPostScreen()),
                  _card(
                      title: 'Add',
                      description: 'your detail',
                      icon: Icons.add_box_outlined,
                      screen: const AddDetailScreen()),
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
      color: Colors.grey[200],
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
                color: SColors.iconColor,
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
      color: Colors.white,
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
              color: SColors.iconColor,
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
                  color: SColors.iconColor,
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
