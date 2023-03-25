import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yuva_again/services/getEvents.dart';
import 'package:yuva_again/services/yourChannels.dart';

class Events extends StatefulWidget {
  const Events({Key? key}) : super(key: key);

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  FirebaseAuth? auth;
  List allEvents = [];
  DateTime initialval = DateTime.now();
  @override
  void initState() {
    super.initState();
    init_wrapper();
  }

  init_wrapper() async {
    List newlist = await getEvents(DateTime.now());
    setState(() {
      allEvents = newlist;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 32.0, 0, 0),
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: 36,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: CalendarTimeline(
                  initialDate: initialval,
                  firstDate: DateTime.now().subtract(Duration(days: 365)),
                  lastDate: DateTime.now().add(Duration(days: 365)),
                  onDateSelected: (date) async {
                    List newlist = await getEvents(date);
                    setState(() {
                      initialval = date;
                      allEvents = newlist;
                    });
                  },
                  leftMargin: 20,
                  monthColor: Colors.grey,
                  dayColor: Colors.black,
                  activeDayColor: Colors.black,
                  activeBackgroundDayColor: Colors.orangeAccent,
                  dotsColor: Color(0xFF333A47),
                  locale: 'en_ISO',
                ),
              )
            ],
          ),
        ),
        allEvents != []
            ? Expanded(
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: allEvents.length,
                    itemBuilder: (context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.25),
                                    blurRadius: 4,
                                    offset: const Offset(0, 4))
                              ],
                              color: Colors.orange.shade200,
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  allEvents[index]['name'],
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    "Date: " + allEvents[index]['date'],
                                    style: GoogleFonts.montserrat(fontSize: 18),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    "Venue: " + allEvents[index]['venue'],
                                    style: GoogleFonts.montserrat(fontSize: 18),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    "Description: " +
                                        allEvents[index]['description'],
                                    style: GoogleFonts.montserrat(fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              )
            : Container(),
      ],
    );
  }
}
