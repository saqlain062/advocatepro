import 'package:advocatepro_f/Methods/share.dart';
import 'package:advocatepro_f/screens/authenticate/sign_in.dart';
import 'package:advocatepro_f/screens/authenticate/sign_up_attribute.dart';
import 'package:advocatepro_f/screens/bottom/profile/profile_attribute.dart';
import 'package:advocatepro_f/screens/bottom/profile/profile_edit_screen.dart';
import 'package:advocatepro_f/screens/bottom/profile/support/support_screen.dart';
import 'package:advocatepro_f/screens/home/home_client_post_screen.dart';
import 'package:advocatepro_f/screens/home/upload_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

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
        backgroundColor: Colors.grey[200],
        body: FutureBuilder<List<SignupAttribute>>(
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
                SignupAttribute userProfile = snapshot.data!.first;
                // Set the initial values for controllers
                final fname = userProfile.fname;
                final lname = userProfile.lname;
                final gmail = userProfile.email;
                return Column(
                  children: [
                    UserAccountsDrawerHeader(
                      currentAccountPicture: FirebaseAnimatedList(
                          query: FirebaseDatabase.instance
                              .ref('Post_${uid()}_profile'),
                          defaultChild:
                              const Center(child: CircularProgressIndicator()),
                          itemBuilder: (context, snapshots, animation, index) {
                            final imageUrl =
                                snapshots.child('url').value.toString();
                            return CircleAvatar(
                                radius: 50,
                                child: imageUrl.isNotEmpty
                                    ? Image.network(
                                        imageUrl,
                                        height: 100,
                                        width: 100,
                                      )
                                    : const CircularProgressIndicator());
                          }),
                      accountName: Text(
                        '$fname $lname',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      accountEmail: Text(gmail),
                      decoration: const BoxDecoration(
                        color: Color(0xff0000ff),
                      ),
                    ),
                    const ListTile(
                        title: Text("My AdvocatePro",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold))),
                    ListTile(
                      leading: const Icon(
                        Icons.edit_note_outlined,
                        color: Color(0xff0000ff),
                      ),
                      title: const Text("Edit Profile"),
                      onTap: () {
                        Navigator.pushNamed(context, ProfileEditScreen.id);
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.share_outlined,
                        color: Color(0xff0000ff),
                      ),
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
                      leading: const Icon(
                        Icons.photo_camera_front_sharp,
                        color: Color(0xff0000ff),
                      ),
                      title: const Text("Account"),
                      onTap: () {
                        Navigator.pushNamed(context, UploadImage.id);
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.logout,
                        color: Color(0xff0000ff),
                      ),
                      title: const Text('Log out'),
                      onTap: () {
                        FirebaseAuth.instance.signOut();
                        Navigator.pushNamed(context, SignIn.id);
                      },
                    ),
                    const Divider(),
                    const ListTile(
                        title: Text("Resource",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold))),
                    ListTile(
                      leading: const Icon(
                        Icons.support_agent_rounded,
                        color: Color(0xff0000ff),
                      ),
                      title: const Text("Support"),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SupportScreen()));
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
