import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yuva_again/screens/registration/personalInfo.dart';
import 'package:yuva_again/widgets/registaration_header.dart';

import '../home.dart';
import 'auth.dart';

class InitializerWidget extends StatefulWidget {
  final registering;
  const InitializerWidget({Key? key, this.registering}) : super(key: key);

  @override
  State<InitializerWidget> createState() => _InitializerWidgetState();
}

class _InitializerWidgetState extends State<InitializerWidget> {
  FirebaseAuth? _auth;
  User? _user;
  bool isLoading = true;
  String username = '';
  @override
  void initState() {
    late SingleValueDropDownController _cnt = SingleValueDropDownController();
    super.initState();
    _auth = FirebaseAuth.instance;
    _user = _auth!.currentUser;
    //FirebaseAuth.instance.signOut();
    route();
  }

  Future<void> route() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('username') != null) {
      setState(() {
        isLoading = false;
        username = prefs.getString('username')!;
      });
    }

    //  if (_user == null) {
    //    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
    //      Navigator.pushReplacement(
    //          context, MaterialPageRoute(builder: (context) => Authenticate()));
    //    });}
    print(_user?.uid);
    if (_user?.uid != null) {
      String? uid = _user?.uid;
      final snapshot = await FirebaseDatabase.instance.ref('users/$uid').get();
      if (snapshot.exists) {
        SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Home()));
        });
      } else {
        SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => PersonalInfo()));
        });
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(
            appBar: AppBar(
              title: const Text("Yuva Again"),
            ),
            body: const Center(child: CircularProgressIndicator()),
          )
        : Scaffold(
            backgroundColor: Color(0xffFEFCF3),
            body: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                RegistrationHeader(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "choose_language".tr(),
                          style: GoogleFonts.alata(
                            fontSize: 26,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 32.0),
                          child: DropDownTextField(
                              onChanged: (value) {
                                print(value.value);
                                if (value.value == "English") {
                                  context.setLocale(Locale('en', 'US'));
                                }
                                if (value.value == "Hindi") {
                                  //  print("Hindi");
                                  context.setLocale(Locale('hi', 'IN'));
                                }
                              },
                              textStyle: GoogleFonts.alata(),
                              listTextStyle: GoogleFonts.alata(),
                              dropDownIconProperty:
                                  IconProperty(color: Colors.black),
                              clearIconProperty:
                                  IconProperty(color: Colors.black),
                              textFieldDecoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xffFDF2C9),
                                  focusColor: Color(0xffFDF2C9),
                                  hoverColor: Color(0xffFDF2C9),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xff12253A))),
                                  labelText: "Languages",
                                  labelStyle: GoogleFonts.alata(
                                      fontSize: 16, color: Colors.black)),
                              dropDownList: const [
                                DropDownValueModel(
                                    name: "English", value: "English"),
                                DropDownValueModel(
                                    name: "Hindi", value: "Hindi")
                              ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 32, 0, 0),
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Authenticate()));
                            },
                            style: ButtonStyle(
                              overlayColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.transparent),
                              padding: MaterialStateProperty.resolveWith(
                                  (states) => EdgeInsets.zero),
                            ),
                            child: Ink(
                              decoration: const BoxDecoration(
                                color: Color(0xff12253A),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              child: Container(
                                constraints: const BoxConstraints(
                                    minWidth: 88.0,
                                    minHeight:
                                        36.0), // min sizes for Material buttons
                                alignment: Alignment.center,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text(
                                    'login'.tr(),
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.alata(
                                        color: Colors.white, fontSize: 24),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 10,
                )
              ],
            ),
          );
  }
}
