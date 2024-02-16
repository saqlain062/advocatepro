import 'package:advocatepro_f/Methods/round_button.dart';
import 'package:advocatepro_f/Methods/toast.dart';
import 'package:advocatepro_f/screens/bottom/profile/advocate_profile.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final TextEditingController _captionController = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _captionController,
                decoration: const InputDecoration(
                  hintText: 'Write a caption...',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
              ),
              const SizedBox(height: 20),
              loading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.blue,
                      ),
                    )
                  : RoundButton(
                      title: 'Add',
                      onTop: () {
                        addPost();
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const AdvocateProfileScreen()));
                      })
            ],
          ),
        ),
      ),
    );
  }

  void addPost() {
    setState(() {
      loading = true;
    });
    String uid = FirebaseAuth.instance.currentUser!.uid;
    String databasePath = 'Post_$uid';
    final databaseReference = FirebaseDatabase.instance.ref(databasePath);
    String id = DateTime.now().millisecondsSinceEpoch.toString();

    // Format time
    String formattedTime = '';
    DateTime postTime = DateTime.now();
    DateTime currentTime = DateTime.now();
    Duration difference = currentTime.difference(postTime);
    if (difference.inDays == 0) {
      // Post was made today, show time
      formattedTime = DateFormat('h:mm a').format(postTime);
    } else if (difference.inDays >= 1) {
      // Post is older than a day, show date and year
      formattedTime = DateFormat('MMM dd').format(postTime);
    } else {
      formattedTime = DateFormat('MMM dd, yyyy').format(postTime);
    }

    databaseReference.child(id).set({
      'id': id,
      'Caption or Content': _captionController.text.toString(),
      'time': formattedTime,
    }).then((value) {
      setState(() {
        loading = false;
      });

      showToast(message: "Posted");
    }).onError((error, stackTrace) {
      setState(() {
        loading = false;
      });

      showToast(message: 'Error:$error');
    });
  }
}
