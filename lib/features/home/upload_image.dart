import 'dart:io';
import 'package:advocatepro_f/Methods/round_button.dart';
import 'package:advocatepro_f/Methods/toast.dart';
import 'package:advocatepro_f/features/home/home_client_post_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
// import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class UploadImage extends StatefulWidget {
  static const String id = 'upload_image';
  UploadImage({super.key, required this.path});
  String path;

  @override
  State<UploadImage> createState() => __UploadImagState();
}

class __UploadImagState extends State<UploadImage> {
  File? _image;
  final picker = ImagePicker();
  bool loading = false;
  final time = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
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
                  Reference storageRef = storage
                      .ref()
                      .child('users/${uid()}/${widget.path}/$time');

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
                      String databasePath = 'users/$uid/${widget.path}/';
                      final databaseReference =
                          FirebaseDatabase.instance.ref(databasePath);
                      String id =
                          DateTime.now().millisecondsSinceEpoch.toString();
                     
                      databaseReference.child(id).set({
                        'id': id,
                        'url': downloadURL.toString(),
                        'time': DateTime.now().toString(),
                      }).then((value) {
                        showToast(message: "SuccessFully down");
                        setState(() {
                          loading = false;
                        });
                        print("posted");
                        Navigator.pop(context);
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
        setState(() {
          _image = File(pickedFile.path);
        });
        // _cropImage(pickedFile);
      } else {
        showToast(message: "No Image Picked");
      }
    });
  }

  // Future<void> _cropImage(XFile? pickedFile) async {
  //   if (pickedFile != null) {
  //     final croppedFile = await ImageCropper().cropImage(
  //       sourcePath: pickedFile.path,
  //        aspectRatioPresets: [
  //       CropAspectRatioPreset.square,
  //       CropAspectRatioPreset.ratio3x2,
  //       CropAspectRatioPreset.original,
  //       CropAspectRatioPreset.ratio4x3,
  //       CropAspectRatioPreset.ratio16x9
  //     ],
  //       compressFormat: ImageCompressFormat.jpg,
  //       compressQuality: 100,
  //       uiSettings: [
  //         AndroidUiSettings(
  //             toolbarTitle: 'Cropper',
  //             toolbarColor: Colors.deepOrange,
  //             toolbarWidgetColor: Colors.white,
  //             initAspectRatio: CropAspectRatioPreset.original,
  //             lockAspectRatio: false),
  //         IOSUiSettings(
  //           title: 'Cropper',
  //         ),
  //       ],
  //     );
  //     if (croppedFile != null) {
  //       setState(() {

  //         _image = File(croppedFile.path);
  //       });
  //     }
  //   }
  // }
}
