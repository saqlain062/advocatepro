import 'package:advocatepro_f/screens/bottom/profile/profile_attribute.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePostScreen extends StatefulWidget {
  const HomePostScreen({super.key});

  @override
  State<HomePostScreen> createState() => _HomePostScreenState();
}

class _HomePostScreenState extends State<HomePostScreen> {
  final ref = FirebaseDatabase.instance.ref(databasePathPost());
  bool verified = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: const Color(
          0xff0000ff
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text('AdvocatePro',style: TextStyle(color: Colors.white),),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display lawyer posts
            Expanded(
              child: FirebaseAnimatedList(
                  query: ref,
                  defaultChild: const Center(child: CircularProgressIndicator()),
                  itemBuilder: (context, snapshots, animation, index) {
                     // Format time

                    String postDateTime =
                        snapshots.child('time').value.toString();
                    String formattedTime = '';

                    // Convert the string to a DateTime object
                    DateTime postTime = DateTime.parse(postDateTime);
                    DateTime currentTime = DateTime.now();
                    Duration difference = currentTime.difference(postTime);
                    if (difference.inDays == 0) {
                      // Post was made today, show time
                      formattedTime = DateFormat('h:mm a').format(postTime);
                    } else if (difference.inDays >= 1) {
                      // Post is older than a day, show date and year
                      formattedTime = DateFormat('MMM dd').format(postTime);
                    } else {
                      formattedTime =
                          DateFormat('MMM dd, yyyy').format(postTime);
                    }
                    return Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            tileColor: Colors.white,
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
                                Text(formattedTime),
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
