import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';

class Header extends StatelessWidget {
  final heading;
  const Header({Key? key, this.heading}) : super(key: key);

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
                Container(color: Color(0xffFBD46D), height: 45),
                Container(
                    color: Color(0xffFBE289).withOpacity(0.4), height: 30),
                Container(height: 40, color: Color(0xffFEFCF3))
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
            ),
            Positioned(
                bottom: 15,
                left: 15,
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Color(0xff333232),
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        size: 32,
                        color: Colors.white,
                      )),
                ))
          ],
        ),
        Text(
          heading.toString().tr(),
          style: GoogleFonts.alata(fontSize: 32),
        ),
      ],
    );
  }
}
