import 'package:advocatepro_f/utils/constants/color.dart';
import 'package:advocatepro_f/features/Forms/form_screen.dart';
import 'package:advocatepro_f/features/chats/inbox_screen.dart';
import 'package:advocatepro_f/features/bottom/profile/advocate_profile_post.dart';
import 'package:advocatepro_f/features/lawyer/screen/homeScreen/home_screen_designe.dart';
import 'package:flutter/material.dart';

import 'features/client/screens/lawyer/lawyer.dart';

class LawyerNavigationMenu extends StatefulWidget {
  static const String id = 'home_screen';
  const LawyerNavigationMenu({super.key});

  @override
  State<LawyerNavigationMenu> createState() => _LawyerNavigationMenuState();
}

class _LawyerNavigationMenuState extends State<LawyerNavigationMenu> {
  @override
  void initState() {
    super.initState();
  }

  int currentIndex = 0;
  final List<Widget> screens = [
    const HomeScreenDesgine(),
    const LawyerScreen(),//FormScreen(),
    const InboxScreen(),
    const AdvocateProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IndexedStack(
          index: currentIndex,
          children: screens,
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: colorWhite,
          iconSize: 30,
          selectedItemColor: SColors.primary,
          unselectedItemColor: const Color.fromRGBO(141, 141, 141, 1),
          showUnselectedLabels: false,
          showSelectedLabels: false,
          currentIndex: currentIndex,
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Form"),
            BottomNavigationBarItem(icon: Icon(Icons.email), label: 'Inbox'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_pin), label: "Profile")
          ],
        ));
  }
}
