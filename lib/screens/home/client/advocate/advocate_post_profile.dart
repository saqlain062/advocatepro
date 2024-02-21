import 'package:advocatepro_f/Methods/toast.dart';
import 'package:advocatepro_f/screens/authenticate/sign_up_attribute.dart';
import 'package:advocatepro_f/screens/bottom/profile/profile_attribute.dart';
import 'package:advocatepro_f/screens/home/home_client_post_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdvocatePostAndProfileScreen extends StatefulWidget {
  final String id;
  const AdvocatePostAndProfileScreen({
    super.key,
    required this.id,
  });

  @override
  State<AdvocatePostAndProfileScreen> createState() =>
      _AdvocatePostAndProfileScreenState();
}

class _AdvocatePostAndProfileScreenState
    extends State<AdvocatePostAndProfileScreen> {
  final ref = FirebaseDatabase.instance.ref(databasePathPost());
  final refprofile =
        FirebaseDatabase.instance.ref('Post_${uid()}_profile');
  final firestore =
      FirebaseFirestore.instance.collection('lawyers').snapshots();
  final controllerEdit = TextEditingController();
  bool verified = false;
  String imageUrl = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getImageUrl();
  }

  Future<void> getImageUrl() async {
    final storage = FirebaseStorage.instance;
    final reff = storage.ref().child('users/${uid()}/profile-pic.jpg');
    final url = await reff.getDownloadURL();
    setState(() {
      imageUrl = url;
    });
  }

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
                 CircleAvatar(
                            radius: 50,
                            child: imageUrl.isNotEmpty
                                ? Image.network(
                                    imageUrl,
                                    height: 100,
                                    width: 100,
                                  )
                                : const CircularProgressIndicator(),
                          )
              ],
            ),
            Row(
              children: [
                StreamBuilder<QuerySnapshot>(
                  stream: firestore,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      print('-----------1--------${snapshot.error}');
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData) {
                      return const Text('No data available');
                    } else {
                      // Check if the ID matches and return the username if true
                      final matchingDoc = snapshot.data!.docs.firstWhere(
                        (doc) => doc.id == widget.id,
                      );

                      return Text(
                        '${matchingDoc['First Name']} ${matchingDoc['Last Name']}',
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }
                  },
                ),
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
                Text('Joined: ${joinedDate()}'),
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
                            leading: FirebaseAnimatedList(
                                query: FirebaseDatabase.instance
                                    .ref('Post_${uid()}_profile'),
                                defaultChild: const Center(
                                    child: CircularProgressIndicator()),
                                itemBuilder:
                                    (context, snapshots, animation, index) {
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
                            title: FutureBuilder<List<SignupAttribute>>(
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
                                    SignupAttribute userProfile =
                                        snapshot.data!.first;
                                    // Set the initial values for controllers
                                    final fname = userProfile.fname;
                                    final lname = userProfile.lname;
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

  Future<String> getUrl() async {
    DatabaseReference ref =
        FirebaseDatabase.instance.ref('Post_${uid()}_profile');
    final event = await ref.once(DatabaseEventType.value);
    final Map<dynamic, dynamic>? data =
        event.snapshot.value as Map<dynamic, dynamic>?;
    if (data != null && data.containsKey('url')) {
      final imageUrl = data['url'];
      return imageUrl.toString();
    } else {
      return 'Anonymous';
    }
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
