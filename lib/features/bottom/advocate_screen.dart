import 'package:advocatepro_f/features/home/client/advocate/advocate_post_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdvocateScreen extends StatefulWidget {
  static const String id = 'advocate_scree';
  const AdvocateScreen({super.key});

  @override
  State<AdvocateScreen> createState() => _AdvocateScreenState();
}

class _AdvocateScreenState extends State<AdvocateScreen> {
  final firestore = FirebaseFirestore.instance.collection('lawyers').snapshots();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Best Advocate'),
        // backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: firestore,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error:${snapshot.error}');
            } else if (!snapshot.hasData) {
              return const Text('No data available');
            } else {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final String id = snapshot.data!.docs[index]['ID'];
                    // ProfileAttribute advocate = snapshot.data!.docs[index] as ProfileAttribute;
                    return ListTile(

                      leading: GestureDetector(
                        child: const Icon(Icons.image),
                      ),
                      title: Text('${snapshot.data!.docs[index]['First Name']} ${snapshot.data!.docs[index]['Last Name']}'),
                      subtitle: Text('${snapshot.data!.docs[index]['ID']}'),
                      trailing: GestureDetector(
                        child: const Icon(Icons.star),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AdvocatePostAndProfileScreen(id: id,)));
                      },
                    );
                  });
            }
          }),
    );
  }
}
