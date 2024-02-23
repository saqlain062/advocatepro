import 'dart:io';

import 'package:advocatepro_f/Methods/round_button.dart';
import 'package:advocatepro_f/Methods/toast.dart';
import 'package:advocatepro_f/screens/home/home_client_post_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class UploadImage extends StatefulWidget {
  static const String id = 'upload_image';
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => __UploadImagState();
}

class __UploadImagState extends State<UploadImage> {
  File? _image;
  CroppedFile? _croppedFile;
  final picker = ImagePicker();
  bool loading = false;
  FirebaseStorage storage = FirebaseStorage.instance;
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
              child: loading
                  ? const CircularProgressIndicator(
                      color: Colors.amber,
                    )
                  : Container(
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
                  setState(() {
                    loading = true;
                  });
                  // Reference to the user's folder in Firebase Storage
                  Reference storageRef =
                      storage.ref().child('users/${uid()}/profile-pic.jpg');
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
                      String uid = FirebaseAuth.instance.currentUser!.uid;
                      String databasePath = 'Post_${uid}_profile';
                      final databaseReference =
                          FirebaseDatabase.instance.ref(databasePath);
                      String id =
                          DateTime.now().millisecondsSinceEpoch.toString();

                      databaseReference.child(id).set({
                        'id': id,
                        'url': downloadURL.toString(),
                        'time': DateTime.now().toString(),
                      }).then((value) {
                        setState(() {
                          loading = false;
                        });
                        print("posted");
                      }).onError((error, stackTrace) {
                        setState(() {
                          loading = false;
                        });
                      });
                    } else {
                      showToast(message: 'Error uploading image');
                    }
                  } catch (e) {
                    showToast(message: 'Error: $e');
                  }
                  showToast(message: "SuccessFully down");
                  setState(() {
                    loading = false;
                  });
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
        _cropImage(pickedFile);
      } else {
        showToast(message: "No Image Picked");
      }
    });
  }

  Future<void> _cropImage(XFile? pickedFile) async {
    if (pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
        ],
      );
      if (croppedFile != null) {
        setState(() {
          _croppedFile = croppedFile;

          _image = File(croppedFile.path);
        });
      }
    }
  }
}

