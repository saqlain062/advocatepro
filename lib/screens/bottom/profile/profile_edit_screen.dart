import 'package:advocatepro_f/check_method.dart';
import 'package:advocatepro_f/screens/bottom/profile/profile_attribute.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProfileEditScreen extends StatefulWidget {
  static const String id = 'profile_edit_screen';
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final _formkey = GlobalKey<FormState>();
  late TextEditingController controllerFirstName = TextEditingController();
  late TextEditingController controllerEmail = TextEditingController();
  late TextEditingController controllerphone = TextEditingController();
  late TextEditingController controllerSecondName = TextEditingController();
  late TextEditingController controllerDoB = TextEditingController();
  late TextEditingController controllerPassword = TextEditingController();
  late TextEditingController controllerLawyerID = TextEditingController();
  final DateFormat format = DateFormat('yyyy-MM-dd');
  late DateTime dateTime;
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Edit profile"),
          actions: const [Text('Save'),Icon(Icons.gpp_good_outlined)],
        ),
        body: SafeArea(
            child: FutureBuilder<List<ProfileAttribute>>(
        future: fetchDataOfCurrentUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error:${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Text('No data available');
          } else {
            // Get the user profile data
              ProfileAttribute userProfile = snapshot.data!.first;
              // Set the initial values for controllers
              controllerFirstName.text = userProfile.object.fname;
              controllerSecondName.text = userProfile.object.lname;
              controllerEmail.text = userProfile.email;
              controllerphone.text = userProfile.phone;
              controllerDoB.text = userProfile.dateofbirth;
            return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                    key: _formkey,
                    child: SingleChildScrollView(
                      child: Column(children: [
                        const Image(
                            height: 100,
                            width: 100,
                            image: AssetImage('images/lawyer.png')),
                        const Center(
                            child: Text(
                          'Edit picture',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        )),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // First Name Field
                            Expanded(
                              child: TextFormField(
                                
                                controller: controllerFirstName,
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.person),
                                    label: const Text('First Name'),
                                    hintText: 'Enter your first name',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide:
                                            const BorderSide(width: 4))),
                                validator: (value) {
                                  return checkname(value);
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            // Second Name Field
                            Expanded(
                              child: TextFormField(
                                controller: controllerSecondName,
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.person),
                                    label: const Text('Second Name'),
                                    hintText: 'Enter your Second Name',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide:
                                            const BorderSide(width: 4))),
                                validator: (value) {
                                  return checkname(value);
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        if (isChecked)
                          TextFormField(
                              controller: controllerLawyerID,
                              decoration: InputDecoration(
                                prefixIcon:
                                    const Icon(Icons.person_pin_rounded),
                                labelText: 'Enter Your lawyer ID',
                                hintText: 'Enter Your lawyer ID',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(width: 4)),
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                return checklist(value);
                              }),
                        const SizedBox(
                          height: 10,
                        ),
                        //Email Field
                        TextFormField(
                          controller: controllerEmail,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.email),
                              label: const Text('Email'),
                              hintText: 'Enter your email',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(width: 4))),
                          validator: (value) {
                            return checkEmail(value);
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // Date of Birth field
                        TextFormField(
                          readOnly: true,
                          onTap: () => calender(context),
                          controller: controllerDoB,
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.calendar_month),
                              label: const Text('DOB'),
                              hintText: 'Enter your Date of Birth',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(width: 4))),
                          validator: (value) => value != null && value.isEmpty
                              ? 'Enter DoB'
                              : null,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // Phone Number Field
                        TextFormField(
                          controller: controllerphone,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.phone),
                              label: const Text('Phone'),
                              hintText: '0300-1234567',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(width: 4))),
                          validator: (value) {
                            return checknumber(value);
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        )
                      ]),
                    )));}})));
  }

  Future<void> calender(BuildContext context) async {
    final DateTime? dateTime = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900, 1, 1),
        lastDate: DateTime.now());
    if (dateTime != null) {
      setState(() {
        controllerDoB.text = format.format(dateTime);
      });
    }
  }
  
}
