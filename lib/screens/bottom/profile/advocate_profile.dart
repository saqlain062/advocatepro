import 'package:advocatepro_f/Methods/toast.dart';
import 'package:advocatepro_f/screens/bottom/profile/profile_attribute.dart';
import 'package:advocatepro_f/screens/bottom/profile/profile_edit_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdvocateProfileScreen extends StatefulWidget {
  const AdvocateProfileScreen({super.key});

  @override
  State<AdvocateProfileScreen> createState() => _AdvocateProfileScreenState();
}

class _AdvocateProfileScreenState extends State<AdvocateProfileScreen> {
  final ref = FirebaseDatabase.instance.ref(databasePathPost());
  final controllerEdit = TextEditingController();
  bool verified = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Profile'),
        // backgroundColor: Colors.blue,
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ProfileEditScreen()));
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
            Row(
              
              children: [
                const Icon(Icons.calendar_month_rounded),
                Text('Joined Date: ${joinedDate()}'),
              ],
            ),
            const SizedBox(
              height: 10,
            ),

            const Text(
              'Post',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Divider(),

            // Display lawyer posts
            Expanded(
              child: FirebaseAnimatedList(
                  query: ref,
                  defaultChild:
                      const Center(child: CircularProgressIndicator()),
                  itemBuilder: (context, snapshots, animation, index) {
                    final title =
                        snapshots.child('Caption or Content').value.toString();
                    final id = snapshots.child('id').value.toString();
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
                            leading: const CircleAvatar(
                              backgroundColor: Colors.blue,
                            ),
                            title: FutureBuilder<List<ProfileAttribute>>(
                                future: fetchDataOfCurrentUser(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  } else if (snapshot.hasError) {
                                    print(
                                        '-----------1--------$snapshot.error');
                                    return Text('Error:${snapshot.error}');
                                  } else if (!snapshot.hasData ||
                                      snapshot.data!.isEmpty) {
                                    return const Text('No data available');
                                  } else {
                                    // Get the user profile data
                                    ProfileAttribute userProfile =
                                        snapshot.data!.first;
                                    // Set the initial values for controllers
                                    final fname = userProfile.object.fname;
                                    final lname = userProfile.object.lname;
                                    return Text(
                                      '$fname $lname',
                                    );
                                  }
                                }),
                            subtitle: Text(formattedTime),
                            trailing: PopupMenuButton(
                              icon: const Icon(Icons.more_vert),
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                    value: 1,
                                    child: ListTile(
                                      onTap: () {
                                        Navigator.pop(context);
                                        showDialogbox(title, id);
                                      },
                                      leading: const Icon(Icons.edit),
                                      title: const Text('Edit'),
                                    )),
                                PopupMenuItem(
                                    value: 1,
                                    child: ListTile(
                                      onTap: () {
                                        ref.child(id).remove();
                                        Navigator.pop(context);
                                      },
                                      leading: const Icon(Icons.delete_outline),
                                      title: const Text('Delete'),
                                    ))
                              ],
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

  Future<void> showDialogbox(String title, String id) async {
    controllerEdit.text = title;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Update"),
            content: TextField(
              controller: controllerEdit,
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel")),
              TextButton(
                onPressed: () {
                  ref
                      .child(id)
                      .update({'Caption or Content': controllerEdit.text})
                      .then((value) => showToast(message: 'Update Post'))
                      .onError((error, stackTrace) =>
                          showToast(message: 'Error:${error.toString()}'));
                          Navigator.pop(context);
                },
                child: const Text("Update"),
              ),
            ],
          );
        });
  }
}

String joinedDate() {
  DateTime? join = FirebaseAuth.instance.currentUser?.metadata.creationTime;
  String formattedTime = DateFormat('MMM dd, yyyy').format(join!);
  return formattedTime;
}

String databasePathPost() {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  String databasePath = 'Post_$uid';
  return databasePath;
}
