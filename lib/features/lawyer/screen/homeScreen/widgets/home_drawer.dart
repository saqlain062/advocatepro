import 'package:advocatepro_f/features/authenticate/screens/signin/sign_in.dart';
import 'package:advocatepro_f/features/authenticate/screens/signup/sign_up_attribute.dart';
import 'package:advocatepro_f/features/bottom/profile/profile_attribute.dart';
import 'package:advocatepro_f/Methods/share.dart';
import 'package:advocatepro_f/common/widgets/images/s_circular_image.dart';
import 'package:advocatepro_f/utils/helpers/cloud_helper_functions.dart';
import 'package:advocatepro_f/lawyer_navigation_menu_.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/constants/color.dart';

class SHomeScreenDrawer extends StatelessWidget {
  const SHomeScreenDrawer({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Colors.white,
        child: FutureBuilder<List<SignupAttribute>>(
            future: fetchDataOfCurrentUser(),
            builder: (context, snapshot) {
              final widget = SCloudHelperFunctions.checkMultiRecordState(
                  snapshot: snapshot);
              // Return appropriate widget based on snapshot state
              if (widget != null) return widget;
    
              // Get the user profile data
              SignupAttribute userProfile = snapshot.data!.first;
              // Set the initial values for controllers
              final fname = userProfile.fname;
              final lname = userProfile.lname;
              final gmail = userProfile.email;
              return ListView(
                padding: EdgeInsets.zero,
                children: [
                  UserAccountsDrawerHeader(
                    currentAccountPicture: SCircularImage(
                      image: imageUrl,
                      isNetworkImage: true,
                    ),
                    accountName: Text('$fname $lname'),
                    accountEmail: Text(gmail),
                    decoration: const BoxDecoration(
                      color: colorAppbar,
                    ),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.home,
                      color: SColors.iconColor,
                    ),
                    title: const Text('Home'),
                    onTap: () {
                      Navigator.pushNamed(context, LawyerNavigationMenu.id);
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.share,
                      color: SColors.iconColor,
                    ),
                    title: const Text('Share'),
                    onTap: () {
                      shareApp();
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.logout,
                      color: SColors.iconColor,
                    ),
                    title: const Text('Log out'),
                    onTap: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.pushNamed(context, SignIn.id);
                    },
                  )
                ],
              );
            }));
  }
}
