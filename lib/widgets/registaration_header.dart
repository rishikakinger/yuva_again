import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegistrationHeader extends StatelessWidget {
  final headingText;
  const RegistrationHeader({Key? key, this.headingText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset("assets/images/oldBackgroundRegistration.png"),
                Container(color: Color(0xffFBD46D), height: 15),
                Container(
                    color: Color(0xffFBE289).withOpacity(0.4), height: 15),
                Container(
                  height: 25,
                )
              ],
            ),
            Positioned(
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xff12253A),
                    borderRadius: BorderRadius.circular(50)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                  child: Text(
                    "Ya",
                    style: GoogleFonts.dancingScript(
                        color: Colors.white, fontSize: 64),
                  ),
                ),
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Text(
            headingText == null
                ? "app_name".tr()
                : "greeting".tr() + headingText,
            style: GoogleFonts.alata(color: Color(0xff2A1F00), fontSize: 30),
          ),
        )
      ],
    );
  }
}
