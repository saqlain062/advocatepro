import 'package:advocatepro_f/Methods/toast.dart';
import 'package:advocatepro_f/common/widgets/images/s_circular_image.dart';
import 'package:advocatepro_f/utils/constants/color.dart';
import 'package:advocatepro_f/features/authenticate/screens/signup/sign_up_attribute.dart';
import 'package:advocatepro_f/features/bottom/profile/profile_attribute.dart';
import 'package:advocatepro_f/features/bottom/profile/profile_edit_screen.dart';
import 'package:advocatepro_f/features/home/home_client_post_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../utils/constants/image_strings.dart';
import '../../personalization/controllers/user_controller.dart';

class AdvocateProfileScreen extends StatefulWidget {
  const AdvocateProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AdvocateProfileScreen> createState() => _AdvocateProfileScreenState();
}

class _AdvocateProfileScreenState extends State<AdvocateProfileScreen> {
  final ref = FirebaseDatabase.instance.ref(databasePathPost());

  String imageUrl = '';

  @override
  void initState() {
    super.initState();
    getImageUrl();
  }

  Future<void> getImageUrl() async {
    final storage = FirebaseStorage.instance;
    final reff =
        storage.ref().child('users/${uid()}/Saqlain_profile_photo.jpg');
    final url = await reff.getDownloadURL();
    setState(() {
      imageUrl = url;
    });
  }

  final controllerEdit = TextEditingController();
  bool verified = false;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorAppbar,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: colorbackground,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: colorAppbar,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SCircularImage(
                    image: imageUrl,
                    isNetworkImage: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                        color: colorBrown,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(),
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfileEditScreen(
                                      imageUrl: imageUrl,
                                    )),
                          );
                        },
                        child: const Text(
                          'Edit Profile',
                          style: TextStyle(color: colorWhite),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: colorAppbar,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  FutureBuilder<List<SignupAttribute>>(
                    future: fetchDataOfCurrentUser(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Text('Error:${snapshot.error}');
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Text('No data available');
                      } else {
                        SignupAttribute user = snapshot.data!.first;
                        return Text(
                          '${user.fname} ${user.lname}',
                          style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
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
            ),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text('@Username'),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(left: 1),
              child: Row(
                children: [
                  const Icon(
                    Icons.calendar_month_rounded,
                    color: SColors.iconColor,
                  ),
                  const SizedBox(width: 5),
                  Text('Joined Date: ${joinedDate()}'),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.only(left: 1),
              child: Text(
                'Post',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(thickness: 5, color: colorAppbar),

            // Display lawyer posts
            Expanded(
              child: FirebaseAnimatedList(
                query: ref,
                defaultChild: const Center(child: CircularProgressIndicator()),
                itemBuilder: (context, snapshots, animation, index) {
                  final title =
                      snapshots.child('Caption or Content').value.toString();
                  final id = snapshots.child('id').value.toString();
                  String postDateTime =
                      snapshots.child('time').value.toString();
                  String formattedTime = DateFormat('MMM dd, yyyy')
                      .format(DateTime.parse(postDateTime));

                  return Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: Obx(() {
                            final networkImage =
                                controller.user.value.profilePicture;
                            final image = networkImage.isNotEmpty
                                ? networkImage
                                : SImages.noimage;

                            return controller.imageUplodaing.value
                                ? const CircularProgressIndicator()
                                : SCircularImage(
                                    image: image,
                                    
                                    isNetworkImage: networkImage.isNotEmpty,
                                  );
                          }),
                          // SizedBox(
                          //   height: 50,
                          //   width: 50,
                          //   child: FirebaseAnimatedList(
                          //     query: FirebaseDatabase.instance
                          //         .ref('Post_${uid()}_profile'),
                          //     itemBuilder:
                          //         (context, snapshots, animation, index) {
                          //       final imageUrl =
                          //           snapshots.child('url').value.toString();
                          //       return CircleAvatar(
                          //         radius: 50,
                          //         child: imageUrl.isNotEmpty
                          //             ? Image.network(
                          //                 imageUrl,
                          //                 height: 100,
                          //                 width: 100,
                          //               )
                          //             : const CircularProgressIndicator(),
                          //       );
                          //     },
                          //   ),
                          // ),
                          title: FutureBuilder<List<SignupAttribute>>(
                            future: fetchDataOfCurrentUser(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Text('Error:${snapshot.error}');
                              } else if (!snapshot.hasData ||
                                  snapshot.data!.isEmpty) {
                                return const Text('No data available');
                              } else {
                                SignupAttribute userProfile =
                                    snapshot.data!.first;
                                final fname = userProfile.fname;
                                final lname = userProfile.lname;
                                return Text('$fname $lname');
                              }
                            },
                          ),
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
                                ),
                              ),
                              PopupMenuItem(
                                value: 1,
                                child: ListTile(
                                  onTap: () {
                                    ref.child(id).remove();
                                    Navigator.pop(context);
                                  },
                                  leading: const Icon(Icons.delete_outline),
                                  title: const Text('Delete'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            snapshots
                                .child('Caption or Content')
                                .value
                                .toString(),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> showDialogbox(String title, String id) async {
    controllerEdit.text = title;
    showDialog(
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
              child: const Text("Cancel"),
            ),
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
      },
    );
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
