import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yuva_again/screens/hobbies/HobbiesPage.dart';
import 'package:yuva_again/screens/hobbies/eventsPage.dart';
import 'package:yuva_again/screens/hobbies/hobbies.dart';
import 'package:yuva_again/widgets/header.dart';
import 'package:alan_voice/alan_voice.dart';

class MenuChoice extends StatefulWidget {
  const MenuChoice({Key? key}) : super(key: key);

  @override
  State<MenuChoice> createState() => _MenuChoiceState();
}

class _MenuChoiceState extends State<MenuChoice> {
  _MenuChoiceState() {
    /// Init Alan Button with project key from Alan Studio
    AlanVoice.addButton("1249d46220175a3253da12841dc64ed42e956eca572e1d8b807a3e2338fdd0dc/stage");

    AlanVoice.onCommand.add((command) =>_handleCommand(command.data));
  }
  void _handleCommand(Map<String,dynamic>command){
    switch(command["command"]){
      case "events":
        Navigator.push(context,
            MaterialPageRoute(builder: (builder) => EventsPage()));
        break;
      case "tracker":
        Navigator.push(context,
            MaterialPageRoute(builder: (builder) => HobbyTracker()));
        break;
      default:
        debugPrint("unknown command");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffFEFCF3),
        body: Column(
          children: [
            Header(heading: "hobbies_and_events"),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 32, horizontal: 32.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (builder) => EventsPage()));
                },
                child: Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            offset: Offset(0, 4),
                            blurRadius: 4)
                      ],
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xfffbf2ce)),
                  child: Column(
                    children: [
                      Image.asset('assets/images/events.png'),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 16),
                        child: Text(
                          "events".tr(),
                          style: GoogleFonts.alata(fontSize: 30),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (builder) => HobbyTracker()));
                },
                child: Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            offset: Offset(0, 4),
                            blurRadius: 4)
                      ],
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xfffbf2ce)),
                  child: Column(
                    children: [
                      Image.asset('assets/images/hobbies.png'),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 16),
                        child: Text(
                          "hobbies".tr(),
                          style: GoogleFonts.alata(fontSize: 30),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
