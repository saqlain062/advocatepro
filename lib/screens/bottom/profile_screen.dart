import 'package:advocatepro_f/Methods/share.dart';
import 'package:advocatepro_f/screens/bottom/profile/profile_attribute.dart';
import 'package:advocatepro_f/screens/bottom/profile/profile_edit_screen.dart';
import 'package:advocatepro_f/screens/bottom/profile/support/support_screen.dart';
import 'package:advocatepro_f/screens/home/upload_image.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ProfileScreen extends StatefulWidget {
  static const String id = "profile_screen";
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder<List<ProfileAttribute>>(
            future: fetchDataOfCurrentUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                print('-----------1--------$snapshot.error');
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
                return Column(
                  children: [
                    UserAccountsDrawerHeader(
                        currentAccountPicture: const CircleAvatar(),
                        accountName: Text('$fname $lname'),
                        accountEmail: Text(gmail)),
                    const ListTile(
                        title: Text("My AdvocatePro",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold))),
                    ListTile(
                      leading: const Icon(Icons.edit_note_outlined),
                      title: const Text("Edit Profile"),
                      onTap: () {
                        Navigator.pushNamed(context, ProfileEditScreen.id);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.share_outlined),
                      title: const Text("Invite Friends"),
                      onTap: () {
                        shareApp();
                      },
                    ),
                    const Divider(), // Automatic divider
                    const ListTile(
                        title: Text("Settings",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold))),
                    ListTile(
                      leading: const Icon(Icons.photo_camera_front_sharp),
                      title: const Text("Account"),
                      onTap: () {
                        Navigator.pushNamed(context, UploadImage.id);
                      },
                    ),
                    const Divider(),
                    const ListTile(
                        title: Text("Resource",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold))),
                    ListTile(
                      leading: const Icon(Icons.support_agent_rounded),
                      title: const Text("Support"),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const SupportScreen()));
                      },
                    ),
                    const Divider(),
                    //using a Column with Divider
                    // const Text("My AdvocatePro",style: TextStyle(fontSize: 20),),
                    // Divider(color: Colors.grey[400],),
                    // SimpleButton(icon: Icons.favorite_border, title: "Saved List", onTop: (){
        
                    // }),
                    // Divider(color: Colors.grey[400],),
                    // SimpleButton(icon: Icons.share_outlined, title: "Invite friends", onTop: (){
        
                    // }),
                    // Divider(color: Colors.grey[400],),
                    // const Text("Settings",style: TextStyle(fontSize: 20),),
                    // Divider(color: Colors.grey[400],),
                    // SimpleButton(icon: Icons.photo_camera_front_sharp, title: "Account", onTop: (){
                    //   Navigator.pushNamed(context, UploadImage.id);
        
                    // }),
                    // Divider(color: Colors.grey[400],),
                    // const Text("Resourse",style: TextStyle(fontSize: 20),),
                    // Divider(color: Colors.grey[400],),
                    // SimpleButton(icon: Icons.support_agent_rounded, title: "Support", onTop: (){
        
                    // }),
                    // Divider(color: Colors.grey[400],),
                  ],
                );
              }
            }));
  }

}
