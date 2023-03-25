import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:yuva_again/services/getNotifications.dart';
import 'package:yuva_again/widgets/header.dart';

import '../../models/reminders.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  List allnotifications = [];
  @override
  void initState() {
    super.initState();
    init_wrapper();
  }

  init_wrapper() async {
    allnotifications = await getNotifications();
    setState(() {
      allnotifications;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffFEFCF3),
        body: Column(
          children: [
            Header(
              heading: "notifications",
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: Hive.box<Reminders>('reminders').listenable(),
                builder: (context, box, _) {
                  final reminders = box.values.toList().cast<Reminders>();
                  if (reminders.length == 0) {
                    print("This is running");
                    return Center(
                      child: Text(
                        "No past notifications",
                        style:
                            GoogleFonts.alata(color: Colors.grey, fontSize: 24),
                      ),
                    );
                  } else {
                    return ListView.builder(
                        itemCount: reminders.length,
                        itemBuilder: (context, int index) {
                          return DateTime.now().isAfter(reminders[index].date)
                              ? (reminders[index].getNotified
                                  ? Padding(
                                      padding: const EdgeInsets.all(21.0),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.25),
                                                  offset: Offset(0, 4),
                                                  blurRadius: 4)
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Color(0xfffbf2ce)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(24.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                reminders[index].category,
                                                style: GoogleFonts.montserrat(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: Text(
                                                  reminders[index].name,
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 18),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container())
                              : Container();
                        });
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
