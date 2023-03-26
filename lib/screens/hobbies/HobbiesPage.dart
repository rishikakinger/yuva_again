import 'dart:math';
import 'dart:async';


import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:yuva_again/models/reminders.dart';
import 'package:yuva_again/utils/saveReminder.dart';
import 'package:yuva_again/widgets/header.dart';
import 'package:intl/intl.dart';
import 'package:alan_voice/alan_voice.dart';

class HobbyTracker extends StatefulWidget {
  const HobbyTracker({Key? key}) : super(key: key);

  @override
  State<HobbyTracker> createState() => _HobbyTrackerState();
}

class _HobbyTrackerState extends State<HobbyTracker> {


  final nameController = TextEditingController();
  FirebaseAuth? auth;
  List categories = ['events', 'voice_channel', 'reminder'];
  bool notified = true;

  bool recurring = false;
  int selectedCategory = -1;
  int categoryIndex = 0;
  List allEvents = [];
  DateTime initialval = DateTime.now();
  DateTime mydate = DateTime.now();
  late TimeOfDay mytime;
  void init_wrapper() {}
  @override
  void initState() {
    super.initState();
    init_wrapper();
  }




  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Color(0xffFEFCF3),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
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
                              color: Color(0xffFBE289).withOpacity(0.4),
                              height: 30),
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
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 12),
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
                          )),
                      Positioned(
                          bottom: 15,
                          right: 15,
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: const Color(0xff333232),
                            child: IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder:
                                          (builder) => StatefulBuilder(
                                          builder: (context, setState) {
                                            return Center(
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                    32,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(12),
                                                  color: Colors.white,
                                                ),
                                                child: Material(
                                                  borderRadius:
                                                  BorderRadius.circular(12),
                                                  child: Column(
                                                    mainAxisSize:
                                                    MainAxisSize.min,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .fromLTRB(
                                                            24.0,
                                                            24,
                                                            24,
                                                            12),
                                                        child: Text(
                                                          'create_a_reminder'
                                                              .tr(),
                                                          style:
                                                          GoogleFonts.alata(
                                                              fontSize: 18),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                            horizontal:
                                                            16.0),
                                                        child: TextField(
                                                          controller:
                                                          nameController,
                                                          style:
                                                          GoogleFonts.alata(
                                                              color: Colors
                                                                  .black),
                                                          decoration: InputDecoration(
                                                              contentPadding:
                                                              EdgeInsets.symmetric(
                                                                  vertical:
                                                                  2,
                                                                  horizontal:
                                                                  16),
                                                              focusedBorder: const OutlineInputBorder(
                                                                  borderSide: BorderSide(
                                                                      color: Color(
                                                                          0xff3F38DD))),
                                                              labelText:
                                                              "name_of_the_reminder"
                                                                  .tr(),
                                                              labelStyle:
                                                              GoogleFonts.alata(
                                                                  fontSize:
                                                                  14,
                                                                  color: Colors
                                                                      .black)),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () async {
                                                          final todayDate =
                                                          DateTime.now();
                                                          final pickDate =
                                                          await showDatePicker(
                                                              locale: context
                                                                  .locale,
                                                              context:
                                                              context,
                                                              initialDate:
                                                              todayDate,
                                                              firstDate:
                                                              todayDate,
                                                              builder: (BuildContext
                                                              context,
                                                                  Widget?
                                                                  child) {
                                                                return Theme(
                                                                  data: ThemeData
                                                                      .light()
                                                                      .copyWith(
                                                                    primaryColor:
                                                                    const Color(0xff3F38DD),
                                                                    accentColor:
                                                                    const Color(0xff3F38DD),
                                                                    colorScheme:
                                                                    ColorScheme.light(primary: const Color(0xff3F38DD)),
                                                                  ),
                                                                  child:
                                                                  child!,
                                                                );
                                                              },
                                                              lastDate: DateTime(
                                                                  todayDate
                                                                      .year +
                                                                      1));
                                                          if (pickDate !=
                                                              null) {
                                                            final pickTime =
                                                            await showTimePicker(
                                                                context:
                                                                context,
                                                                builder: (BuildContext
                                                                context,
                                                                    Widget?
                                                                    child) {
                                                                  return Theme(
                                                                    data: ThemeData.light()
                                                                        .copyWith(
                                                                      primaryColor:
                                                                      const Color(0xff3F38DD),
                                                                      accentColor:
                                                                      const Color(0xff3F38DD),
                                                                      colorScheme:
                                                                      ColorScheme.light(primary: const Color(0xff3F38DD)),
                                                                    ),
                                                                    child:
                                                                    child!,
                                                                  );
                                                                },
                                                                initialTime: const TimeOfDay(
                                                                    hour: 9,
                                                                    minute:
                                                                    0));
                                                            if (pickTime !=
                                                                null) {
                                                              setState(() {
                                                                mydate = DateTime(
                                                                    pickDate
                                                                        .year,
                                                                    pickDate
                                                                        .month,
                                                                    pickDate
                                                                        .day,
                                                                    pickTime
                                                                        .hour,
                                                                    pickTime
                                                                        .minute);
                                                              });
                                                            }
                                                          }
                                                        },
                                                        child: Padding(
                                                          padding:
                                                          const EdgeInsets
                                                              .all(12.0),
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                decoration: BoxDecoration(
                                                                    color: Color(
                                                                        0xff3F38DD)
                                                                        .withOpacity(
                                                                        0.17),
                                                                    borderRadius:
                                                                    BorderRadius.circular(
                                                                        12)),
                                                                child: Padding(
                                                                  padding:
                                                                  const EdgeInsets
                                                                      .all(
                                                                      8.0),
                                                                  child: Icon(
                                                                    Icons
                                                                        .calendar_today,
                                                                    color: Color(
                                                                        0xff3F38DD),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left:
                                                                    8.0),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                                  children: [
                                                                    Text(
                                                                      "${mydate.day} ${DateFormat('MMMM').format(mydate)}, ${mydate.year}",
                                                                      style: GoogleFonts.alata(
                                                                          fontSize:
                                                                          14),
                                                                    ),
                                                                    Text(
                                                                        "${DateFormat('EEEE').format(mydate)}," +
                                                                            DateFormat('h:mm a').format(
                                                                                mydate),
                                                                        style: GoogleFonts.alata(
                                                                            color:
                                                                            Color(0xff767676),
                                                                            fontSize: 14))
                                                                  ],
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .all(12.0),
                                                        child: InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              categoryIndex =
                                                                  (categoryIndex +
                                                                      1) %
                                                                      categories
                                                                          .length;
                                                              print(
                                                                  categoryIndex);
                                                            });
                                                          },
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                decoration: BoxDecoration(
                                                                    color: Color(
                                                                        0xff3F38DD)
                                                                        .withOpacity(
                                                                        0.17),
                                                                    borderRadius:
                                                                    BorderRadius.circular(
                                                                        12)),
                                                                child:
                                                                const Padding(
                                                                  padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                      8.0),
                                                                  child: Icon(
                                                                    Icons
                                                                        .category,
                                                                    color: Color(
                                                                        0xff3F38DD),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left:
                                                                    8.0),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                                  children: [
                                                                    Text(
                                                                      "category"
                                                                          .tr(),
                                                                      style: GoogleFonts.alata(
                                                                          fontSize:
                                                                          14),
                                                                    ),
                                                                    Text(
                                                                        categories[categoryIndex]
                                                                            .toString()
                                                                            .tr(),
                                                                        style: GoogleFonts.alata(
                                                                            color:
                                                                            Color(0xff767676),
                                                                            fontSize: 14))
                                                                  ],
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .all(12.0),
                                                        child: InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              if (notified ==
                                                                  false) {
                                                                notified = true;
                                                              } else {
                                                                notified =
                                                                false;
                                                              }
                                                            }
                                                            );
                                                          },
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                decoration: BoxDecoration(
                                                                    color: Color(
                                                                        0xff3F38DD)
                                                                        .withOpacity(
                                                                        0.17),
                                                                    borderRadius:
                                                                    BorderRadius.circular(
                                                                        12)),
                                                                child:
                                                                const Padding(
                                                                  padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                      8.0),
                                                                  child: Icon(
                                                                    Icons
                                                                        .notifications,
                                                                    color: Color(
                                                                        0xff3F38DD),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left:
                                                                    8.0),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                                  children: [
                                                                    Text(
                                                                      "get_notified"
                                                                          .tr(),
                                                                      style: GoogleFonts.alata(
                                                                          fontSize:
                                                                          14),
                                                                    ),
                                                                    Text(
                                                                        notified
                                                                            ? "yes"
                                                                            .tr()
                                                                            : 'no'
                                                                            .tr(),
                                                                        style: GoogleFonts.alata(
                                                                            color:
                                                                            Color(0xff767676),
                                                                            fontSize: 14))
                                                                  ],
                                                                ),
                                                              ),


                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .all(12.0),
                                                        child: InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              if (recurring ==
                                                                  false) {
                                                                recurring = true;
                                                              } else {
                                                                recurring =
                                                                false;
                                                              }
                                                            }
                                                            );
                                                          },
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                decoration: BoxDecoration(
                                                                    color: Color(
                                                                        0xff3F38DD)
                                                                        .withOpacity(
                                                                        0.17),
                                                                    borderRadius:
                                                                    BorderRadius.circular(
                                                                        12)),
                                                                child:
                                                                const Padding(
                                                                  padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                      8.0),
                                                                  child: Icon(
                                                                    Icons
                                                                        .question_mark,
                                                                    color: Color(
                                                                        0xff3F38DD),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left:
                                                                    8.0),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                                  children: [
                                                                    Text(
                                                                      "Make recurring"
                                                                          .tr(),
                                                                      style: GoogleFonts.alata(
                                                                          fontSize:
                                                                          14),
                                                                    ),
                                                                    Text(
                                                                        recurring
                                                                            ? "yes"
                                                                            .tr()
                                                                            : 'no'
                                                                            .tr(),
                                                                        style: GoogleFonts.alata(
                                                                            color:
                                                                            Color(0xff767676),
                                                                            fontSize: 14))
                                                                  ],
                                                                ),
                                                              ),


                                                            ],
                                                          ),
                                                        ),
                                                      ),


                                                      TextButton(
                                                          onPressed: () {
                                                            saveReminder(
                                                                nameController
                                                                    .text,
                                                                mydate,
                                                                notified,
                                                                categories[
                                                                categoryIndex],
                                                                recurring, false);


                                                            while (recurring==true)
                                                            {

                                                              recurring=false;

                                                              var timer = Timer(Duration(seconds: 60), () =>

                                                            AwesomeNotifications().createNotification(
                                                            content: NotificationContent(
                                                            id: Random()
                                                                .nextInt(
                                                            100),
                                                            title: categories[
                                                            categoryIndex],
                                                            body: nameController
                                                                .text,
                                                            channelKey:
                                                            'Yuva Again'),
                                                            schedule: NotificationCalendar.fromDate(date:
                                                            mydate)));
                                                              timer.cancel();
                                                              recurring=false;
                                                            }
                                                            if (notified ==
                                                                true&&recurring==false) {

                                                                    AwesomeNotifications().createNotification(
                                                                    content: NotificationContent(
                                                                    id: Random()
                                                                        .nextInt(
                                                                    100),
                                                                    title: categories[
                                                                    categoryIndex],
                                                                    body: nameController
                                                                        .text,
                                                                    channelKey:
                                                                    'Yuva Again'),
                                                                    schedule: NotificationCalendar
                                                                        .fromDate(
                                                                    date:
                                                                    mydate));
                                                                    }

                                                          },
                                                          child: Container(
                                                            width: MediaQuery.of(
                                                                context)
                                                                .size
                                                                .width -
                                                                48,
                                                            decoration: BoxDecoration(
                                                                color: Color(
                                                                    0xff5A68F6),
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    12)),
                                                            child: Padding(
                                                              padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                              child: Text(
                                                                "add".tr(),
                                                                textAlign:
                                                                TextAlign
                                                                    .center,
                                                                style: GoogleFonts.alata(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                    16),
                                                              ),
                                                            ),
                                                          ))
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          }));
                                },
                                icon: const Icon(
                                  Icons.add,
                                  size: 32,
                                  color: Colors.white,
                                )),
                          ))
                    ],
                  ),
                  Text(
                    "hobby_tracker".tr(),
                    style: GoogleFonts.alata(fontSize: 32),
                  ),
                ],
              ),
              ValueListenableBuilder(
                valueListenable: Hive.box<Reminders>('reminders').listenable(),
                builder: (context, box, _) {
                  final reminders = box.values.toList().cast<Reminders>();
                  for (int i = 0; i < reminders.length; i++) {
                    if (reminders[i].done == false) {
                      return CalendarTimeline(
                        initialDate: initialval,
                        firstDate: DateTime.now().subtract(Duration(days: 365)),
                        lastDate: DateTime.now().add(Duration(days: 365)),
                        onDateSelected: (date) async {
                          setState(() {
                            initialval = date;
                          });
                        },
                        leftMargin: 20,
                        monthColor: Colors.grey,
                        dayColor: Colors.black,
                        activeDayColor: Colors.white,
                        activeBackgroundDayColor: Color(0xffFDBC4C),
                        dotsColor: Colors.white,
                        locale: 'en_ISO',
                      );
                    }
                  }
                  return CalendarTimeline(
                    initialDate: initialval,
                    firstDate: DateTime.now().subtract(Duration(days: 365)),
                    lastDate: DateTime.now().add(Duration(days: 365)),
                    onDateSelected: (date) async {
                      setState(() {
                        initialval = date;
                      });
                    },
                    leftMargin: 20,
                    monthColor: Colors.grey,
                    dayColor: Colors.black,
                    activeDayColor: Colors.white,
                    activeBackgroundDayColor: Color(0xff00B6AA),
                    dotsColor: Colors.white,
                    locale: context.locale.languageCode,
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 16, 0, 16),
                child: Text(
                  "my_tasks".tr(),
                  style: GoogleFonts.alata(fontSize: 32),
                ),
              ),
              Container(
                height: 175,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              selectedCategory = index;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12)),
                            width: 150,
                            height: 125,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    categories[index].toString().tr(),
                                    style: GoogleFonts.alata(
                                        fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: Hive.box<Reminders>('reminders').listenable(),
                    builder: (context, box, _) {
                      final reminders = box.values.toList().cast<Reminders>();
                      return ListView.builder(
                          itemCount: reminders.length,
                          itemBuilder: (context, int index) {
                            return reminders[index].date.year == initialval.year &&
                                reminders[index].date.month == initialval.month &&
                                reminders[index].date.day == initialval.day
                                ? (selectedCategory == -1
                                ? ReminderCard(reminders[index], index)
                                : (reminders[index].category ==
                                categories[selectedCategory]
                                ? ReminderCard(reminders[index], index)
                                : Container()))
                                : Container();
                          });
                    },
                  ))
            ],
          ),
        ));
  }

  Widget ReminderCard(Reminders reminder, int index) {
    Color _color = Color.fromRGBO(
        Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1);
    return Dismissible(
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        reminder.delete();
      },
      key: UniqueKey(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: InkWell(
          onTap: () {
            if (reminder.done == false) {
              reminder.done = true;
            } else {
              reminder.done = false;
            }
            reminder.save();
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 7,
                        height: 75,
                        decoration: BoxDecoration(
                            color: _color,
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              reminder.category.tr(),
                              style: GoogleFonts.alata(color: _color),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(vertical: 2.0),
                              child: Text(
                                reminder.name,
                                style: GoogleFonts.alata(fontSize: 24),
                              ),
                            ),
                            Text(
                              DateFormat('h:mm a').format(reminder.date),
                              style:
                              GoogleFonts.alata(color: Color(0xff91D7E0)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 16.0),
                    child: Icon(
                      reminder.done == false
                          ? Icons.circle_outlined
                          : Icons.check_circle_rounded,
                      color: Colors.green,
                      size: 32,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );

  }
}
