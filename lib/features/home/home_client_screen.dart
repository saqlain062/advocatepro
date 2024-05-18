import 'package:advocatepro_f/features/Forms/form_screen.dart';
import 'package:advocatepro_f/features/bottom/advocate_screen.dart';
import 'package:advocatepro_f/features/chats/inbox_screen.dart';
import 'package:advocatepro_f/features/bottom/profile_screen.dart';
import 'package:advocatepro_f/features/home/home_client_post_screen.dart';
import 'package:flutter/material.dart';

class ClientHomeScreen extends StatefulWidget {
  static const String id = 'client_home_screen';
  const ClientHomeScreen({super.key});

  @override
  State<ClientHomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<ClientHomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  int currentIndex = 0;
  final List<Widget> screens = [
    const HomePostScreen(),
    const FormScreen(),
    const InboxScreen(),
    const AdvocateScreen(),
    const ProfileScreen(),
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
          backgroundColor: Colors.white,
          selectedItemColor: const Color(0xff0000ff),
          unselectedItemColor: Colors.black,
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
                icon: Icon(Icons.person_search), label: 'Advocate'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_pin), label: "Profile")
          ],
        ));
  }
}
