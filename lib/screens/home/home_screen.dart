import 'package:advocatepro_f/screens/Forms/form_screen.dart';
import 'package:advocatepro_f/screens/bottom/advocate_screen.dart';
import 'package:advocatepro_f/screens/bottom/inbox_screen.dart';
import 'package:advocatepro_f/screens/home/home_screen_designe.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 
  @override
  void initState() {
    super.initState();
  }

  int currentIndex = 0;
  final List<Widget> screens = [
    const HomeScreenDesgine(),
    const FormScreen(),
    const InboxScreen(),
    const AdvocateScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IndexedStack(
          index: currentIndex,
          children: screens,),
        
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.blue,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          currentIndex: currentIndex,
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Form"),
            BottomNavigationBarItem(icon: Icon(Icons.email), label: 'Inbox'),
            BottomNavigationBarItem(icon: Icon(Icons.person_search), label: 'Advocate'),
            BottomNavigationBarItem(icon: Icon(Icons.person_pin), label: "Profile")
          ],
        )
        );
      
  }
}
