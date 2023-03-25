import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yuva_again/screens/voiceChannels/audioPage.dart';
import 'package:yuva_again/services/treeIncrementor.dart';
import 'package:yuva_again/services/yourChannels.dart';
import 'package:yuva_again/widgets/header.dart';

class VoiceChannels extends StatefulWidget {
  const VoiceChannels({Key? key}) : super(key: key);

  @override
  State<VoiceChannels> createState() => _VoiceChannelsState();
}

class _VoiceChannelsState extends State<VoiceChannels> {
  FirebaseAuth? auth;
  List yourchannels = [];
  bool explore = false;
  @override
  void initState() {
    super.initState();
    auth = FirebaseAuth.instance;
    init_wrapper();
  }

  init_wrapper() async {
    String uid = auth!.currentUser!.uid;
    List channels = await yourChannels(uid);
    print(await yourChannels(uid));
    setState(() {
      yourchannels = channels;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color(0xffFEFCF3),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(
                heading: "Voice channels",
              ),
              Container(
                color: Color(0xfffbf2ce),
                child: Row(
                  children: explore == false
                      ? [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.25),
                                    offset: Offset(0, 4),
                                    blurRadius: 4)
                              ], borderRadius: BorderRadius.circular(20)),
                              child: TextButton(
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                      ),
                                      backgroundColor:
                                          MaterialStateColor.resolveWith(
                                              (states) => Color(0xffFBD46D))),
                                  onPressed: () {
                                    setState(() {
                                      explore = false;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text("Your channels",
                                        style: GoogleFonts.alata(
                                            color: Color(0xff2A1F00),
                                            fontSize: 26)),
                                  )),
                            ),
                          ),
                          Expanded(
                            child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    explore = true;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    "Explore",
                                    style: GoogleFonts.alata(
                                        color: Color(0xff2A1F00), fontSize: 26),
                                  ),
                                )),
                          )
                        ]
                      : [
                          Expanded(
                            child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    explore = false;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    "Your channels",
                                    style: GoogleFonts.alata(
                                        color: Color(0xff2A1F00), fontSize: 26),
                                  ),
                                )),
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.25),
                                    offset: Offset(0, 4),
                                    blurRadius: 4)
                              ], borderRadius: BorderRadius.circular(20)),
                              child: TextButton(
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                      ),
                                      backgroundColor:
                                          MaterialStateColor.resolveWith(
                                              (states) => Color(0xffFBD46D))),
                                  onPressed: () {
                                    setState(() {
                                      explore = true;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text("Explore",
                                        style: GoogleFonts.alata(
                                            color: Color(0xff2A1F00),
                                            fontSize: 26)),
                                  )),
                            ),
                          ),
                        ],
                ),
              ),
              explore
                  ? Container(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(32, 32.0, 32, 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                keyboardType: TextInputType.number,
                                style: GoogleFonts.alata(color: Colors.black),
                                decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.search,
                                        color: Color(0xff12253A),
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Color(0xffFDF2C9),
                                    focusColor: Color(0xffFDF2C9),
                                    hoverColor: Color(0xffFDF2C9),
                                    focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xff12253A))),
                                    labelText: "Search",
                                    labelStyle: GoogleFonts.alata(
                                        fontSize: 16,
                                        color: Color(0xff12253A))),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(),
              Expanded(
                child: ListView.builder(
                    itemCount: yourchannels.length,
                    itemBuilder: (context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 32, horizontal: 32.0),
                        child: InkWell(
                          onTap: channelClicked,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset('assets/images/events.png'),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 8.0, 0, 4),
                                  child: Text(
                                    yourchannels[index],
                                    style: GoogleFonts.alata(fontSize: 30),
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(bottom: 16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.25),
                                                  offset: Offset(0, 4),
                                                  blurRadius: 4)
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: TextButton(
                                            style: ButtonStyle(
                                                shape:
                                                    MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                  ),
                                                ),
                                                backgroundColor:
                                                    MaterialStateColor
                                                        .resolveWith((states) =>
                                                            Color(0xffFBD46D))),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (builder) =>
                                                          Audio()));
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 4.0,
                                                      horizontal: 32),
                                              child: Text("JOIN",
                                                  style: GoogleFonts.alata(
                                                      color: Color(0xff2A1F00),
                                                      fontSize: 20)),
                                            )),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          )),
    );
  }

  channelClicked() {
    treeincrement(auth!.currentUser!.uid);
    Navigator.push(context, MaterialPageRoute(builder: (builder) => Audio()));
  }
}
