import 'package:advocatepro_f/Methods/round_button.dart';
import 'package:advocatepro_f/Methods/toast.dart';
import 'package:advocatepro_f/utils/validators/check_method.dart';
import 'package:advocatepro_f/utils/constants/color.dart';
import 'package:advocatepro_f/features/authenticate/screens/signup/sign_up_attribute.dart';
import 'package:advocatepro_f/features/home/upload_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProfileEditScreen extends StatefulWidget {
  static const String id = 'profile_edit_screen';
  final String imageUrl ;
  const ProfileEditScreen({super.key, required this.imageUrl
  });

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
  late TextEditingController controllerSpecilization = TextEditingController();
  final DateFormat format = DateFormat('yyyy-MM-dd');
  late DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorbackground,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: colorAppbarIcon),
          backgroundColor: colorAppbar,
          centerTitle: true,
          title: const Text(
            "Edit profile",
            style: TextStyle(color: colorAppbarText),
          ),
        ),
        body: SafeArea(
            child: FutureBuilder<List<SignupAttribute>>(
                future: fetchDataforupdateCurrentUser(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error:${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text('No data available');
                  } else {
                    // Get the user profile data
                    SignupAttribute userProfile = snapshot.data!.first;
                    // Set the initial values for controllers
                    controllerFirstName.text = userProfile.fname;
                    controllerSecondName.text = userProfile.lname;
                    controllerEmail.text = userProfile.email;
                    controllerphone.text = userProfile.phone;
                    controllerDoB.text = userProfile.dateofbirth;
                    String checkUser = userProfile.laywerOrNot;
                    return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Form(
                            key: _formkey,
                            child: SingleChildScrollView(
                              child: Column(children: [
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => UploadImage(path: 'profile',
                                    )));
                                  },
                                  child: CircleAvatar(
                    radius: 50,
                        child: widget.imageUrl.isNotEmpty
                            ? Image.network(widget.imageUrl)
                            : const CircularProgressIndicator(),
                      ),),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // First Name Field
                                    Expanded(
                                      child: TextFormField(
                                        controller: controllerFirstName,
                                        keyboardType: TextInputType.name,
                                        decoration: InputDecoration(
                                            prefixIcon: const Icon(
                                              Icons.person,
                                              color: SColors.iconColor,
                                            ),
                                            label: const Text('First Name'),
                                            hintText: 'Enter your first name',
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    width: 4))),
                                        validator: (value) {
                                          return SValidator.checkname(value);
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
                                            prefixIcon: const Icon(
                                              Icons.person,
                                              color: SColors.iconColor,
                                            ),
                                            label: const Text('Second Name'),
                                            hintText: 'Enter your Second Name',
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    width: 4))),
                                        validator: (value) {
                                          return SValidator.checkname(value);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                if (checkUser != '' || checkUser != 'Null')
                                  TextFormField(
                                      controller: controllerLawyerID,
                                      decoration: InputDecoration(
                                        prefixIcon: const Icon(
                                          Icons.person_pin_rounded,
                                          color: SColors.iconColor,
                                        ),
                                        labelText: 'Enter Your lawyer ID',
                                        hintText: 'Enter Your lawyer ID',
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide:
                                                const BorderSide(width: 4)),
                                      ),
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        return SValidator.checkDigits(value);
                                      }),
                                const SizedBox(
                                  height: 10,
                                ),
                                if (checkUser != '' || checkUser != 'Null')
                                TextFormField(
                                      controller: controllerSpecilization,
                                      decoration: InputDecoration(
                                        prefixIcon: const Icon(
                                          Icons.format_list_bulleted_rounded,
                                          color: SColors.iconColor,
                                        ),
                                        labelText: 'Specialization',
                                        hintText: 'Specialization Field',
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide:
                                                const BorderSide(width: 4)),
                                      ),
                                      keyboardType: TextInputType.text,
                                      validator: (value) {
                                        return SValidator.checkname(value);
                                      }),
                                const SizedBox(
                                  height: 10,
                                ),
                                //Email Field
                                TextFormField(
                                  controller: controllerEmail,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.email,
                                        color: SColors.iconColor,
                                      ),
                                      label: const Text('Email'),
                                      hintText: 'Enter your email',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide:
                                              const BorderSide(width: 4))),
                                  validator: (value) {
                                    return SValidator.checkEmail(value);
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
                                      prefixIcon: const Icon(
                                        Icons.calendar_month,
                                        color: SColors.iconColor,
                                      ),
                                      label: const Text('DOB'),
                                      hintText: 'Enter your Date of Birth',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide:
                                              const BorderSide(width: 4))),
                                  validator: (value) =>
                                      value != null && value.isEmpty
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
                                      prefixIcon: const Icon(
                                        Icons.phone,
                                        color: SColors.iconColor,
                                      ),
                                      label: const Text('Phone'),
                                      hintText: '0300-1234567',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide:
                                              const BorderSide(width: 4))),
                                  validator: (value) {
                                    return SValidator.checkPhoneNumber(value);
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                RoundButton(title: 'Update Date', onTop: (){
                                  if(_formkey.currentState!.validate()){
                                    if(checkUser != '' || checkUser != 'Null'){
                                      updateLawyerProfile();
                                    }else{
                                      updateUserProfile();
                                    }
                                  }
                                })
                              ]),
                            )));
                  }
                })));
  }

  Future<void> calender(BuildContext context) async {
    final DateTime? dateTime = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900, 1, 1),
        lastDate: DateTime.now());
    if (dateTime != null) {
        controllerDoB.text = format.format(dateTime);
    }
  }

  Future<List<SignupAttribute>> fetchDataforupdateCurrentUser() async {
  List<SignupAttribute> profileList = [];
  try {
    // Get the current user's UID
    String uid = FirebaseAuth.instance.currentUser!.uid;
    
    // Check if the user is a lawyer
    DocumentSnapshot<Map<String, dynamic>> userDocLawyerCollection =
        await FirebaseFirestore.instance.collection('Users').doc(uid).get();

    if (userDocLawyerCollection.exists) {
      profileList.add(SignupAttribute(
        id: userDocLawyerCollection['BarID'] ?? '',
        fname: userDocLawyerCollection["FirstName"] ?? '',
        lname: userDocLawyerCollection['LastName'] ?? '',
        specialization: userDocLawyerCollection['BarID'] ?? '',
        laywerOrNot: userDocLawyerCollection['BarID'] ?? '',
        email: userDocLawyerCollection['Email'] ?? '',
        phone: userDocLawyerCollection['PhoneNumber'] ?? '',
        dateofbirth: userDocLawyerCollection['BarID'] ?? '',
      ));
    } else {
      // User is not a lawyer, check if the user exists in the 'users' collection
      DocumentSnapshot<Map<String, dynamic>> userDocUserCollection =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (userDocUserCollection.exists) {
        profileList.add(SignupAttribute(
          id: userDocUserCollection['ID'] ?? '',
          fname: userDocUserCollection["First Name"] ?? '',
          lname: userDocUserCollection['Last Name'] ?? '',
          specialization: userDocUserCollection['Specialization'] ?? '',
          laywerOrNot: userDocUserCollection['Lawyer ID'] ?? '',
          email: userDocUserCollection['Email'] ?? '',
          phone: userDocUserCollection['Phone'] ?? '',
          dateofbirth: userDocUserCollection['DOB'] ?? '',
        ));
      } else {
        showToast(message: "No data found for the current user");
      }
    }
  } catch (e) {
    print('---------E-----------$e');
    showToast(message: 'Error fetching data: $e');
  }
  print(profileList);
  return profileList;
}

  Future<void> updateUserProfile() async {
    try {
      // Get the current user ID
      final useruid = FirebaseAuth.instance.currentUser!.uid;
      // Reference to the Firestore collection
      final userCollection = FirebaseFirestore.instance.collection("users");

      // Update the document in the collection
      final newUser = SignupAttribute(
        id: useruid,
        fname: controllerFirstName.text,
        lname: controllerSecondName.text,
        phone: controllerPassword.text,
        email: controllerEmail.text,
        laywerOrNot: controllerLawyerID.text,
        specialization: controllerSpecilization.text,
        dateofbirth: controllerDoB.text,
      ).toJson();
      await userCollection.doc(useruid).update(newUser);

      showToast(message: "Profile updated successfully");
    } catch (error) {
      showToast(message: "Failed to update profile: $error");
    }
  }

   Future<void> updateLawyerProfile() async {
    try {
      // Get the current user ID
      final useruid = FirebaseAuth.instance.currentUser!.uid;
      // Reference to the Firestore collection
      final userCollection = FirebaseFirestore.instance.collection("lawyers");

      // Update the document in the collection
      final newUser = SignupAttribute(
        id: useruid,
        fname: controllerFirstName.text,
        lname: controllerSecondName.text,
        phone: controllerphone.text,
        email: controllerEmail.text,
        laywerOrNot: controllerLawyerID.text,
        specialization: controllerSpecilization.text,
        dateofbirth: controllerDoB.text,
      ).toJson();
      await userCollection.doc(useruid).update(newUser);

      showToast(message: "Profile updated successfully");
    } catch (error) {
      showToast(message: "Failed to update profile: $error");
    }
  }
}
