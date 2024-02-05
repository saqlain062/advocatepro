import 'package:advocatepro_f/screens/home/upload_image.dart';
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
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(),
              accountName: Text("Saqlain"),
              accountEmail: Text("gmail")),
          const ListTile(
              title: Text("My AdvocatePro",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
          ListTile(
            leading: const Icon(Icons.favorite_border),
            title: const Text("Saved List"),
            onTap: () {
              // Handle Saved List navigation
            },
          ),
          ListTile(
            leading: const Icon(Icons.share_outlined),
            title: const Text("Invite Friends"),
            onTap: () {
              // Handle Invite Friends navigation
            },
          ),
          const Divider(), // Automatic divider
          const ListTile(
              title: Text("Settings",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
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
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
          ListTile(
            leading: const Icon(Icons.support_agent_rounded),
            title: const Text("Support"),
            onTap: () {
              // Handle Support navigation
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
      ),
    );
  }
}
