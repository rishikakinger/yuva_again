import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yuva_again/widgets/registaration_header.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yuva_again/screens/home.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:yuva_again/services/getChannels.dart';

import 'package:location/location.dart';

class HobbiesRegistration extends StatefulWidget {
  final name, age, gender;
  const HobbiesRegistration({Key? key, this.name, this.age, this.gender})
      : super(key: key);

  @override
  State<HobbiesRegistration> createState() => _HobbiesRegistrationState();
}

class _HobbiesRegistrationState extends State<HobbiesRegistration> {
  late MultiValueDropDownController _cntMult = MultiValueDropDownController();
  late MultiValueDropDownController _cntMulti = MultiValueDropDownController();
  List<DropDownValueModel> current_interests = [];
  FirebaseAuth? _auth;
  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    //_auth!.signOut();
    init_wrapper();
    // _user = _auth!.currentUser;
  }

  init_wrapper() async {
    print("this is running");
    print(await getsChannels());
    List channels = await getsChannels();
    List<DropDownValueModel> allchannels = channels
        .map(
          (e) => DropDownValueModel(name: e, value: e),
        )
        .toList();
    setState(() {
      current_interests = allchannels;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 24, 0, 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  RegistrationHeader(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 48.0, 24, 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: DropDownTextField.multiSelection(
                            controller: _cntMult,
                            submitButtonTextStyle:
                                GoogleFonts.alata(color: Colors.white),
                            checkBoxProperty: CheckBoxProperty(
                                activeColor: Color(0xff12253A)),
                            submitButtonColor: Color(0xff12253A),
                            listTextStyle:
                                GoogleFonts.alata(color: Colors.black),
                            dropDownList: current_interests,
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
                                labelText: "Current Interests",
                                labelStyle: GoogleFonts.alata(
                                    fontSize: 16, color: Color(0xff12253A))),
                            validator: (value) {
                              if (value == null) {
                                return "Required field";
                              } else {
                                return null;
                              }

                            },
                            onChanged: (val) {},
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 8.0, 24, 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: DropDownTextField.multiSelection(
                            controller: _cntMulti,
                            submitButtonTextStyle:
                                GoogleFonts.alata(color: Colors.white),
                            checkBoxProperty: CheckBoxProperty(
                                activeColor: Color(0xff12253A)),
                            submitButtonColor: Color(0xff12253A),
                            listTextStyle: GoogleFonts.alata(),
                            dropDownList: current_interests,
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
                                labelText: "Hobbies that you want to build",
                                labelStyle: GoogleFonts.alata(
                                    fontSize: 16, color: Color(0xff12253A))),
                            validator: (value) {
                              if (value == null) {
                                return "Required field";
                              } else {
                                return null;
                              }

                            },
                            onChanged: (val) {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
                child: Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        color: Colors.black.withOpacity(0.25))
                  ]),
                  child: TextButton(
                    onPressed: personal_added,
                    style: ButtonStyle(
                      overlayColor: MaterialStateColor.resolveWith(
                          (states) => Colors.transparent),
                      padding: MaterialStateProperty.resolveWith(
                          (states) => EdgeInsets.zero),
                    ),
                    child: Ink(
                      decoration: const BoxDecoration(
                        color: Color(0xff12253A),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: Container(
                        constraints: const BoxConstraints(
                            minWidth: 88.0,
                            minHeight: 36.0), // min sizes for Material buttons
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            'Submit',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.alata(
                                color: Colors.white, fontSize: 24),
                          ),
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
    );
  }

  personal_added() async {
    var loc = await Location().getLocation();
    print(_auth?.currentUser);
    DatabaseReference ref =
        FirebaseDatabase.instance.ref('users/' + _auth!.currentUser!.uid);
    String latlong = loc.latitude.toString() + ',' + loc.longitude.toString();
    await ref.set({
      "Name": widget.name,
      "Age": widget.age,
      "Gender": widget.gender,
      "Current Interests":
          _cntMult.dropDownValueList!.map((e) => e.name).toList().toString(),
      "Future Interests":
          _cntMulti.dropDownValueList!.map((e) => e.name).toList().toString(),
      'location': latlong
    });
    List currentinterest =
        _cntMult.dropDownValueList!.map((e) => e.name).toList();
    List futureinterest =
        _cntMulti.dropDownValueList!.map((e) => e.name).toList();

    for (int i = 0; i < currentinterest.length; i++) {
      String nameofchannel = currentinterest[i];
      FirebaseDatabase.instance
          .ref('channels/$nameofchannel')
          .update({_auth!.currentUser!.uid: 'Current Interests'});
    }

    for (int i = 0; i < futureinterest.length; i++) {
      String nameofchannel = futureinterest[i];
      FirebaseDatabase.instance
          .ref('channels/$nameofchannel')
          .update({_auth!.currentUser!.uid: 'Future Interests'});
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
  }
}
