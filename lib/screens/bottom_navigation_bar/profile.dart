import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yuva_again/screens/home.dart';
import 'package:yuva_again/services/getMyChannels.dart';
import 'package:alan_voice/alan_voice.dart';
import '../../services/getChannels.dart';
import 'notifications.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  _ProfileState() {
    /// Init Alan Button with project key from Alan Studio
    AlanVoice.addButton("1249d46220175a3253da12841dc64ed42e956eca572e1d8b807a3e2338fdd0dc/stage");



    AlanVoice.onCommand.add((command) =>_handleCommand(command.data));
  }
  void _handleCommand(Map<String,dynamic>command){
    switch(command["command"]){
      case "Home":
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (builder) => Home()));
        break;

      default:
        debugPrint("unknown command");
    }
  }

  FirebaseAuth? _auth;
  String name = "";
  TextEditingController phoneno = TextEditingController();
  List<DropDownValueModel> current_interests = [];
  List myChannels = [];
  late MultiValueDropDownController _cntMult = MultiValueDropDownController();
  @override
  void initState() {
    super.initState();
    init_wrapper();
  }

  init_wrapper() async {
    _auth = FirebaseAuth.instance;
    print(_auth?.currentUser?.phoneNumber);
    phoneno.text = (_auth?.currentUser?.phoneNumber)!;
    phoneno.value = TextEditingValue(text: (_auth?.currentUser?.phoneNumber)!);
    print("Getting channels");
    List channels = await getsChannels();
    Map mychannels = await getMyChannels(_auth?.currentUser?.uid);
    print(mychannels);
    print(mychannels['name']);
    List<DropDownValueModel> allchannels = channels
        .map(
          (e) => DropDownValueModel(name: e, value: e),
        )
        .toList();
    List<DropDownValueModel>? dropdownChannels =
        List<DropDownValueModel>.from(mychannels['interests'].map((e) {
      print(e.toString().trim());
      return DropDownValueModel(
          name: e.toString().trim(), value: e.toString().trim());
    }).toList());
    _cntMult.setDropDown(dropdownChannels);
    setState(() {
      name = mychannels['name'];
      current_interests = allchannels;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xffFEFCF3),
      body: Column(
        children: [
          Expanded(
              child: Column(
            children: [
              Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/profileGradient.png'),
                                fit: BoxFit.cover)),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 5,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 75,
                      ),
                    ],
                  ),
                  Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.contain,
                                image:
                                    AssetImage("assets/images/Customer.png"))),
                      ))
                ],
              ),
              Text(
                name,
                style: GoogleFonts.alata(fontSize: 32),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Text(
                        "phone_no".tr(),
                        style: GoogleFonts.alata(fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                      child: TextField(
                        controller: phoneno,
                        keyboardType: TextInputType.number,
                        style: GoogleFonts.alata(color: Colors.black),
                        decoration: InputDecoration(
                            filled: true,
                            //      fillColor: Color(0xffFDF2C9),
                            //      focusColor: Color(0xffFDF2C9),
                            //      hoverColor: Color(0xffFDF2C9),
                            focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff12253A))),
                            //      labelText: "Age",
                            labelStyle: GoogleFonts.alata(
                                fontSize: 16, color: Color(0xff12253A))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Text(
                        "hobbies".tr(),
                        style: GoogleFonts.alata(fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                      child: DropDownTextField.multiSelection(
                        controller: _cntMult,
                        submitButtonTextStyle:
                            GoogleFonts.alata(color: Colors.white),
                        checkBoxProperty:
                            CheckBoxProperty(activeColor: Color(0xff12253A)),
                        submitButtonColor: Color(0xff12253A),
                        listTextStyle: GoogleFonts.alata(color: Colors.black),
                        dropDownList: current_interests,
                        dropDownIconProperty: IconProperty(color: Colors.black),
                        clearIconProperty: IconProperty(color: Colors.black),
                        textFieldDecoration: InputDecoration(
                            filled: true,
                            //      fillColor: Color(0xffFDF2C9),
                            //      focusColor: Color(0xffFDF2C9),
                            //      hoverColor: Color(0xffFDF2C9),
                            focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff12253A))),
                            //      labelText: "Age",
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
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Text(
                        "language".tr(),
                        style: GoogleFonts.alata(fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
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
                          initialValue: context.locale.languageCode == "hi"
                              ? "Hindi"
                              : "English",
                          textStyle: GoogleFonts.alata(),
                          listTextStyle: GoogleFonts.alata(),
                          dropDownIconProperty:
                              IconProperty(color: Colors.black),
                          clearIconProperty: IconProperty(color: Colors.black),
                          textFieldDecoration: InputDecoration(
                              filled: true,
                              //      fillColor: Color(0xffFDF2C9),
                              //      focusColor: Color(0xffFDF2C9),
                              //      hoverColor: Color(0xffFDF2C9),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff12253A))),
                              //      labelText: "Age",
                              labelStyle: GoogleFonts.alata(
                                  fontSize: 16, color: Color(0xff12253A))),
                          dropDownList: const [
                            DropDownValueModel(
                                name: "English", value: "English"),
                            DropDownValueModel(name: "Hindi", value: "Hindi")
                          ]),
                    ),
                  ],
                ),
              )
            ],
          )),
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
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (builder) => Home()));
                        },
                        icon: Icon(
                          Icons.home,
                          size: 34,
                          color: Color(0xffFCE39A),
                        )),

                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.person,
                          size: 34,
                          color: Color(0xffFDBC4C),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
