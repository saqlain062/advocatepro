import 'dart:io';

import 'package:advocatepro_f/Methods/round_button.dart';
import 'package:advocatepro_f/Methods/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadImage extends StatefulWidget {
  static const String id = 'upload_image';
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => __UploadImagState();
}

class __UploadImagState extends State<UploadImage> {
  File? _image;
  final picker = ImagePicker();

  // FirebaseStorage storage = FirebaseStorage.instance;
  // DatabaseReference databaseReference = FirebaseDatabase.instance.ref("Profile_Image") ;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                getGalleryImage();
              },
              child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        color: Colors.black,
                      )),
                  child: _image != null
                      ? Image.file(_image!.absolute)
                      : const Center(
                          child: Icon(
                          Icons.cameraswitch_rounded,
                          size: 100,
                        ))),
            ),
            const SizedBox(
              height: 30,
            ),
            RoundButton(
                title: "Uplaod",
                onTop: () async {
                  // Reference ref = FirebaseStorage.instance.ref("/foldername"+"11234");

                  // // UploadTask uploadTask = ref.putFile(_image!.absolute);

                  // // await Future.value(uploadTask);

                  // // var newUrl = ref.getDownloadURL();

                  // // databaseReference.child('1').set({
                  // //   'id' : "1212",
                  // //   'title' : newUrl.toString()
                  // // });

                  // Get the current user
                  User? user = _auth.currentUser;

                  // Reference to the user's folder in Firebase Storage
                  Reference storageRef = _storage
                      .ref()
                      .child('users/${user!.uid}/profile-pic.jpg');

                  // Display loading indicator or disable the button
                  // while the image is being uploaded
                  // (You can use a loading state or a modal dialog)

                  try {
                    // Upload the image file
                    UploadTask uploadTask = storageRef.putFile(_image!);

                    // Get the upload task snapshot
                    TaskSnapshot taskSnapshot = await uploadTask;

                    // Display success message or handle errors
                    if (taskSnapshot.state == TaskState.success) {
                      showToast(message: 'Image uploaded successfully!');
                      String downloadURL = await storageRef.getDownloadURL();
                      print('Download URL: $downloadURL');
                    } else {
                      showToast(message: 'Error uploading image');
                    }
                  } catch (e) {
                    showToast(message: 'Error: $e');
                  }

                  showToast(message: "SuccessFully down");
                })
          ],
        ),
      ),
    );
  }

  Future getGalleryImage() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery); //imageQuality:80
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        showToast(message: "No Image Picked");
      }
    });
  }
}
