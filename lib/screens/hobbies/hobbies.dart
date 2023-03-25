import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yuva_again/screens/hobbies/events.dart';
import 'package:yuva_again/screens/bottom_navigation_bar/notifications.dart';

import '../../services/treeIncrementor.dart';

class Hobbies extends StatefulWidget {
  const Hobbies({Key? key}) : super(key: key);

  @override
  State<Hobbies> createState() => _HobbiesState();
}

class _HobbiesState extends State<Hobbies> {
  int bottom_nav_index = 0;
  @override
  void initState() {
    super.initState();
    print(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          selectedLabelStyle: GoogleFonts.montserrat(fontSize: 18),
          unselectedLabelStyle: GoogleFonts.montserrat(fontSize: 18),
          selectedItemColor: Colors.orangeAccent,
          unselectedItemColor: Colors.black,
          currentIndex: bottom_nav_index,
          onTap: (int index) {
            treeincrement(FirebaseAuth.instance!.currentUser!.uid);
            setState(() {
              bottom_nav_index = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.notifications,
                ),
                label: 'Notifications'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.event,
                ),
                label: "Events"),
          ]),
      body: bottom_nav_index == 0 ? Notifications() : Events(),
    ));
  }
}
