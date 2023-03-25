import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xffFAF3EB),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 0, 75),
                  child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: 42,
                      ))),
              Image.asset('assets/images/image 6.png')
            ],
          ),
          Transform.translate(
            offset: Offset(0, -50),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 0, 0, 24),
                      child: Text(
                        "Welcome \nback!",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold, fontSize: 40),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: TextField(
                    style: GoogleFonts.montserrat(color: Color(0xff868484)),
                    decoration: InputDecoration(
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff868484))),
                        labelText: "Email",
                        labelStyle: GoogleFonts.montserrat(
                            fontSize: 16, color: Color(0xff868484))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: TextField(
                    style: GoogleFonts.montserrat(color: Color(0xff868484)),
                    decoration: InputDecoration(
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff868484))),
                        labelText: "Password",
                        labelStyle: GoogleFonts.montserrat(
                            fontSize: 16, color: Color(0xff868484))),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: TextButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          overlayColor: MaterialStateColor.resolveWith(
                              (states) => Colors.transparent),
                          padding: MaterialStateProperty.resolveWith(
                              (states) => EdgeInsets.zero),
                        ),
                        child: Text('Forgot Password?',
                            style: GoogleFonts.montserrat(
                                color: Color(0xffFF6B00),
                                fontWeight: FontWeight.w500,
                                fontSize: 16)),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 32, 15.0, 32),
                  child: TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      overlayColor: MaterialStateColor.resolveWith(
                          (states) => Colors.transparent),
                      padding: MaterialStateProperty.resolveWith(
                          (states) => EdgeInsets.zero),
                    ),
                    child: Ink(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Color.fromRGBO(255, 107, 0, 0.84),
                              Color.fromRGBO(251, 206, 47, 0.75)
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter),
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      ),
                      child: Container(
                        constraints: const BoxConstraints(
                            minWidth: 88.0,
                            minHeight: 36.0), // min sizes for Material buttons
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            'Login',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 24),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  "Don't have an account?",
                  style: GoogleFonts.montserrat(),
                ),
                TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    overlayColor: MaterialStateColor.resolveWith(
                        (states) => Colors.transparent),
                    padding: MaterialStateProperty.resolveWith(
                        (states) => EdgeInsets.zero),
                  ),
                  child: Text(
                    "Sign Up",
                    style: GoogleFonts.montserrat(
                        color: Color(0xffFF6B00),
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        decoration: TextDecoration.underline),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
