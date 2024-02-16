import 'package:advocatepro_f/Methods/share.dart';
import 'package:advocatepro_f/check_method.dart';
import 'package:advocatepro_f/screens/Forms/form_attribute.dart';
import 'package:advocatepro_f/screens/authenticate/sign_in.dart';
import 'package:advocatepro_f/screens/bottom/profile/profile_attribute.dart';
import 'package:advocatepro_f/screens/bottom/profile/support/supportscreen/feedback_screen.dart';
import 'package:advocatepro_f/screens/home/add_post_screen.dart';
import 'package:advocatepro_f/screens/home/case/case_screen.dart';
import 'package:advocatepro_f/screens/home/client/client_management_screen.dart';
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

  void refreshpage() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text('AdvocatePro'),
        // backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Handle notifications
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to settings screen
            },
          ),
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
        
        child: SingleChildScrollView(
          child: Column(
            
            children: [

            if (internet) const InternetError(),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Center(
                  child: Text(
                'Welcome to AdvocatePro!',
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              )),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(224, 224, 224, 1),
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
    SingleChildScrollView(
      scrollDirection: Axis.horizontal,

      child: Row(
        children: [
          _card(title: 'Add Post', description: 'Null', icon: Icons.photo_size_select_actual_rounded, screen: const AddPostScreen()),
          _card(title: 'Add Post', description: 'Null', icon: Icons.photo_size_select_actual_rounded, screen: const AddPostScreen()),
          _card(title: 'Add Post', description: 'Null', icon: Icons.photo_size_select_actual_rounded, screen: const AddPostScreen()),
          _card(title: 'Add Post', description: 'Null', icon: Icons.photo_size_select_actual_rounded, screen: const AddPostScreen()),
          _card(title: 'Add Post', description: 'Null', icon: Icons.photo_size_select_actual_rounded, screen: const AddPostScreen()), 
        ],
      ),
    ),
    const SizedBox(height: 20),
            _homeCard(title: 'Cases', description: "Manage your Client Case here", icon: Icons.file_copy, screen: const CaseManagementScreen(),imageUrl: 'images/lawyerIcon.png'),
            _homeCard(title: 'Clients', description: "Manage your Client", icon: Icons.person_add_alt_1, screen: const ClientManagementScreen(),imageUrl: 'images/lawyer.png'),
            _homeCard(title: 'Feedback', description: "Feedback or Suggestion", icon: Icons.feedback, screen: const FeedbackScreen(),imageUrl: 'images/IMG_20230814_230618_015.jpg'),
              ],
            ),
          ]),
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
    width: 150,
    height: 170, // Adjust the height of the container as needed
    decoration: const BoxDecoration(
      boxShadow: [BoxShadow(
        color: Color.fromRGBO(224, 224, 224, 1),
        offset: Offset(5,5),
        blurRadius: 10,
      )]    ),
    child: Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 2.0,
      color: Colors.white,
      child: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
        },
        child: Column(
          children: [
            Icon(icon, size: 36),
            Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),),
            Text(
            description,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          ],
        ),
      ),
    ),
  );
}
  Widget _homeCard({
    required String title,
    required String description,
    required IconData icon, 
    required String imageUrl,
    required screen,
  }) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 2.0,
      color: Colors.white,
      child: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => screen));

        },
      child:  Column(
        children: [
          AspectRatio(
                aspectRatio: 16 / 9, // Adjust the aspect ratio as needed
                child: Image.asset(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
      
      ListTile(
        leading: Icon(icon, size: 36),
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
      )
    );
  }
  @override
  void dispose() {
    controllersearch.dispose();
    super.dispose();
  }
}
