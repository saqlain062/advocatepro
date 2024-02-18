import 'package:advocatepro_f/screens/bottom/profile/advocate_profile.dart';
import 'package:advocatepro_f/screens/bottom/profile/profile_attribute.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdvocateScreen extends StatefulWidget {
  static const String id = 'advocate_scree';
  const AdvocateScreen({super.key});

  @override
  State<AdvocateScreen> createState() => _AdvocateScreenState();
}

class _AdvocateScreenState extends State<AdvocateScreen> {
  final firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Best Advocate'),
        // backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder<List<ProfileAttribute>>(
          future: fetchDataOfAllLawyers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error:${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text('No data available');
            } else {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    ProfileAttribute advocate = snapshot.data![index];
                    return ListTile(
                      leading: GestureDetector(
                        child: const Icon(Icons.image),
                      ),
                      title: Text('${advocate.object.fname} ${advocate.object.lname}'),
                      subtitle: Text(advocate.email),
                      trailing: GestureDetector(
                        child: const Icon(Icons.star),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AdvocateProfileScreen()));
                      },
                    );
                  });
            }
          }),
    );
  }
}
