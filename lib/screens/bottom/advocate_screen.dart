import 'package:advocatepro_f/screens/bottom/advocate_attaribute.dart';
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
      body: FutureBuilder<List<AdvocateAttribute>>(
        future: fetchDataFromLawyersCollection(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting){
            return const CircularProgressIndicator();
          } else if (snapshot.hasError){
            return Text('Error:${snapshot.error}');

          } else if (!snapshot.hasData || snapshot.data!.isEmpty ){
            return const Text('No data available');
          } else {
            return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            AdvocateAttribute advocate = snapshot.data![index];
            return ListTile(
              leading: GestureDetector(
                child: const Icon(Icons.image),
              ),
              title: Text('${advocate.fname} ${advocate.lname}'),
              subtitle: Text(advocate.id),
              trailing: GestureDetector(
                child: const Icon(Icons.star),
              ),
            );
          },
        );
          }
        }, 
      ),
    );
  }


}
