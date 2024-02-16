import 'package:advocatepro_f/screens/bottom/profile/profile_attribute.dart';
import 'package:advocatepro_f/screens/bottom/profile/profile_edit_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class AdvocateProfileScreen extends StatefulWidget {
  const AdvocateProfileScreen({super.key});

  @override
  State<AdvocateProfileScreen> createState() => _AdvocateProfileScreenState();
}

class _AdvocateProfileScreenState extends State<AdvocateProfileScreen> {
  final ref = FirebaseDatabase.instance.ref(databasePathPost());
  bool verified = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(150),
        child: AppBar(
          backgroundColor: Colors.blue,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('images/lawyerIcon.png'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all()),
                    child: TextButton(
                      child: const Text('Edit Profile'),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileEditScreen()));
                      },
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                FutureBuilder<List<ProfileAttribute>>(
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
                  
                        return Text(
                          '$fname $lname',
                          style: const TextStyle(
                            // color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }
                    }),
                const SizedBox(width: 8),
                Visibility(
                  visible: verified,
                  child: const Icon(Icons.verified_user, color: Colors.green),
                )
              ],
            ),
            const Text('@Username'),
            const SizedBox(
              height: 20,
            ),
            const Text('Icon Joined Date'),
            const SizedBox(
              height: 10,
            ),

            const Text('Post',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
            ),
            const Divider(),

            // Display lawyer posts
            Expanded(
              child: FirebaseAnimatedList(
                  query: ref,
                  defaultChild: const Center(child: CircularProgressIndicator()),
                  itemBuilder: (context, snapshots, animation, index) {
                    return Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            leading: const CircleAvatar(
                              backgroundColor: Colors.blue,
                            ),
                            title: FutureBuilder<List<ProfileAttribute>>(
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
                        return Text(
                              '$fname $lname',
                            );}}),
                            subtitle:
                                Text(snapshots.child('time').value.toString()),
                            trailing: IconButton(
                              icon: const Icon(Icons.linear_scale_sharp),
                              onPressed: () {},
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(snapshots
                                .child('Caption or Content')
                                .value
                                .toString()),
                          ),
                        ],
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}

String? uid() {
  String? uid = FirebaseAuth.instance.currentUser!.displayName;

  return uid;
}

String databasePathPost() {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  String databasePath = 'Post_$uid';
  return databasePath;
}
