import 'dart:async';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart';
import 'package:text_to_speech/text_to_speech.dart';
import 'package:yuva_again/screens/bottom_navigation_bar/profile.dart';
import 'package:yuva_again/screens/games/games.dart';
import 'package:yuva_again/screens/hobbies/choice.dart';
import 'package:yuva_again/screens/hobbies/hobbies.dart';
import 'package:yuva_again/screens/bottom_navigation_bar/notifications.dart';
import 'package:yuva_again/screens/voiceChannels/voiceChannels.dart';
import 'package:alan_voice/alan_voice.dart';
import '../services/treeIncrementor.dart';
import '../widgets/registaration_header.dart';

class Home extends StatefulWidget {
  final username;
  const Home({Key? key, this.username}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  _HomeState() {
    /// Init Alan Button with project key from Alan Studio
    AlanVoice.addButton("1249d46220175a3253da12841dc64ed42e956eca572e1d8b807a3e2338fdd0dc/stage");

    /// Handle commands from Alan Studio
    AlanVoice.onCommand.add((command) {
      debugPrint("got new command ${command.toString()}");
    });
  }
  FirebaseAuth? _auth;
  String greetings = '';
  Artboard? riveartboard;
  late StreamSubscription stream;
  StateMachineController? stateMachineController;
  SMIInput<double>? _progress;
  List<BoxShadow> boxShadows = [
    BoxShadow(
        offset: Offset(0, 1),
        color: Colors.black.withOpacity(0.25),
        blurRadius: 1,
        spreadRadius: 0),
    BoxShadow(
        offset: Offset(0, 0),
        color: Color(0xffFDF2C9).withOpacity(1),
        blurRadius: 0,
        spreadRadius: 1),
    BoxShadow(
        offset: Offset(0, 2),
        color: Color(0xffCBCAC2).withOpacity(1),
        blurRadius: 5,
        spreadRadius: 0),
    BoxShadow(
        offset: Offset(0, 1),
        color: Color(0xffFDF2C9).withOpacity(1),
        blurRadius: 0,
        spreadRadius: 0)
  ];
  bool loadingtreeScore = true;
  @override
  void initState() {
    super.initState();
    init_wrapper();
  }

  init_wrapper() async {
    _auth = FirebaseAuth.instance;
    await greeting();
    await rootBundle.load('assets/tree_demo1.riv').then((data) async {
      print('Loaded');
      final file = RiveFile.import(data);
      final artboard = file.mainArtboard;
      print(artboard);
      var controller =
          StateMachineController.fromArtboard(artboard, 'State Machine 1');
      print(controller);
      if (controller != null) {
        artboard.addController(controller);
        _progress = controller.findInput('input');
        setState(() {
          loadingtreeScore = false;
          riveartboard = artboard;
        });
      }
    });
    DatabaseReference ref =
        FirebaseDatabase.instance.ref('users/' + _auth!.currentUser!.uid);
    stream = ref.onValue.listen((event) {
      var data = Map<String, dynamic>.from(event.snapshot.value as dynamic);
      print(data);
      int myscore = data['treeScore'] != null ? data['treeScore'] : 0;
      setState(() {
        _progress?.value = myscore.toDouble();
      });
    });
  }

  greeting() async {
    final ref = FirebaseDatabase.instance.ref();
    String user = _auth!.currentUser!.uid;
    final snapshot = await ref.child('users/$user').get();
    if (snapshot.exists) {
      var data = Map<String, dynamic>.from(snapshot.value as dynamic);
      setState(() {
        greetings = data['Name'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(

      child: Scaffold(
        backgroundColor: Color(0xffFEFCF3),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RegistrationHeader(
                  headingText: greetings,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            treeincrement(_auth!.currentUser!.uid);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => VoiceChannels()));
                          },
                          child: Ink(
                            decoration: BoxDecoration(
                                boxShadow: boxShadows,
                                color: Color(0xffFDF2C9),
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                    "assets/images/Microphone.png",
                                    width: 30,
                                  ),
                                  Text(
                                    'Video Channels'.tr(),
                                    style: GoogleFonts.alata(
                                        color: Colors.black, fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            treeincrement(_auth!.currentUser!.uid);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => MenuChoice()));
                          },
                          child: Ink(
                            decoration: BoxDecoration(
                                boxShadow: boxShadows,
                                color: Color(0xffFDF2C9),
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                    "assets/images/Schedule.png",
                                    width: 20,
                                  ),
                                  Text(
                                    'hobbies'.tr(),
                                    style: GoogleFonts.alata(
                                        color: Colors.black, fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            treeincrement(_auth!.currentUser!.uid);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => Games(
                                          url:
                                              "https://www.seniorsonline.vic.gov.au/services-information/games",
                                        )));
                          },
                          child: Ink(
                            decoration: BoxDecoration(
                                boxShadow: boxShadows,
                                color: Color(0xffFDF2C9),
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                    "assets/images/Game.png",
                                    width: 20,
                                  ),
                                  Text(
                                    'games'.tr(),
                                    style: GoogleFonts.alata(
                                        color: Colors.black, fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: loadingtreeScore
                  ? Center(child: CircularProgressIndicator())
                  : Rive(
                      artboard: riveartboard!,
                      alignment: Alignment.center,
                    ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 16),
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xff333232),
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 8, 0, 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => Notifications()));
                          },
                          icon: Icon(
                            Icons.notifications,
                            size: 34,
                            color: Color(0xffFCE39A),
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.home,
                            size: 34,
                            color: Color(0xffFDBC4C),
                          )),
                      // IconButton(
                      //     onPressed: () {},
                      //
                      //     icon: Icon(
                      //       Icons.speaker,
                      //       size: 34,
                      //       color: Color(0xffFCE39A),
                      //     )),

                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => Profile()));
                          },
                          icon: Icon(
                            Icons.person,
                            size: 34,
                            color: Color(0xffFCE39A),
                          )),
                    ],
                  ),
                ),
              ),

            ),
          ],
        ),
      ),
    );
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    stream.cancel();
    super.deactivate();
  }
}
