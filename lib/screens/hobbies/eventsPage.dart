import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:yuva_again/screens/games/games.dart';
import 'package:yuva_again/widgets/header.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EventsPage extends StatefulWidget {
  const EventsPage({Key? key}) : super(key: key);

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  List eventsList = [];
  String search = "";
  late LocationData currentData;
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    init_wrapper();
  }

  init_wrapper() async {
    // var eventsResp = await http.read(Uri.parse(
    //     "https://app.ticketmaster.com/discovery/v2/events.json?apikey=8EBZVX4HGDVrCyRkFTxJMFOw6Qr8yejX"));
    // var eventsObj = json.decode(eventsResp);
    LocationData loc = await Location().getLocation();

    var response = await http.get(
        Uri.parse(
            "https://www.eventbriteapi.com/v3/organizations/1303518490023/events/?expand=venue"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer TZWBG44SYMXZZAMFDSCF',
        });
    print(json.decode(response.body)['events']);
    setState(() {
      currentData = loc;
      eventsList = json.decode(response.body)['events'];
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
            heading: "events",
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(32, 32.0, 32, 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      style: GoogleFonts.alata(color: Colors.black),
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                search = searchController.text;
                              });
                            },
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
                              borderSide: BorderSide(color: Color(0xff12253A))),
                          labelText: "search".tr(),
                          labelStyle: GoogleFonts.alata(
                              fontSize: 16, color: Color(0xff12253A))),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: eventsList.length,
                  itemBuilder: (context, int index) {
                    final Distance distance = new Distance();
                    print(distance.as(
                        LengthUnit.Kilometer,
                        LatLng(currentData.latitude!, currentData.longitude!),
                        LatLng(
                            double.parse(
                                eventsList[index]['venue']['latitude']),
                            double.parse(
                                eventsList[index]['venue']['longitude']))));
                    if (eventsList[index]['name']['text'].contains(search) &&
                        distance.as(
                                LengthUnit.Kilometer,
                                LatLng(currentData.latitude!,
                                    currentData.longitude!),
                                LatLng(
                                    double.parse(
                                        eventsList[index]['venue']['latitude']),
                                    double.parse(eventsList[index]['venue']
                                        ['longitude']))) <=
                            15060) {
                      return Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (builder) => Center(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                32,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: Colors.white,
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                child: Image.network(
                                                  eventsList[index]['logo']
                                                      ['url'],
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      64,
                                                  fit: BoxFit.fill,
                                                  height: 100,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 24.0),
                                              child: Text(
                                                eventsList[index]['name']
                                                    ['text'],
                                                style: GoogleFonts.alata(
                                                    fontSize: 18),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color: Color(0xff3F38DD)
                                                            .withOpacity(0.17),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Icon(
                                                        Icons.calendar_today,
                                                        color:
                                                            Color(0xff3F38DD),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "${DateTime.parse(eventsList[index]['start']['local']).day} ${DateFormat('MMMM').format(DateTime.parse(eventsList[index]['start']['local']))}, ${DateTime.parse(eventsList[index]['start']['local']).year}",
                                                          style:
                                                              GoogleFonts.alata(
                                                                  fontSize: 14),
                                                        ),
                                                        Text(
                                                            "${DateFormat('EEEE').format(DateTime.parse(eventsList[index]['start']['local']))}, ${DateTime.parse(eventsList[index]['start']['local']).hour}:${DateTime.parse(eventsList[index]['start']['local']).minute}",
                                                            style: GoogleFonts.alata(
                                                                color: Color(
                                                                    0xff767676),
                                                                fontSize: 14))
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color: Color(0xff3F38DD)
                                                            .withOpacity(0.17),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Icon(
                                                        Icons.location_on,
                                                        color:
                                                            Color(0xff3F38DD),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          eventsList[index]
                                                              ['venue']['name'],
                                                          style:
                                                              GoogleFonts.alata(
                                                                  fontSize: 14),
                                                        ),
                                                        Text(
                                                            eventsList[index][
                                                                        'venue']
                                                                    ['address'][
                                                                'localized_address_display'],
                                                            style: GoogleFonts.alata(
                                                                color: Color(
                                                                    0xff767676),
                                                                fontSize: 14))
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color: Color(0xff3F38DD)
                                                            .withOpacity(0.17),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Icon(
                                                        Icons.person,
                                                        color:
                                                            Color(0xff3F38DD),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "Yuva Again",
                                                          style:
                                                              GoogleFonts.alata(
                                                                  fontSize: 14),
                                                        ),
                                                        Text("Organizer",
                                                            style: GoogleFonts.alata(
                                                                color: Color(
                                                                    0xff767676),
                                                                fontSize: 14))
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 24.0),
                                              child: Text(
                                                eventsList[index]['description']
                                                    ['text'],
                                                style: GoogleFonts.alata(
                                                    fontSize: 18),
                                              ),
                                            ),
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (builder) =>
                                                              Games(
                                                                  url: eventsList[
                                                                          index]
                                                                      [
                                                                      'url'])));
                                                },
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      48,
                                                  decoration: BoxDecoration(
                                                      color: Color(0xff5A68F6),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      "GOING",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: GoogleFonts.alata(
                                                          color: Colors.white,
                                                          fontSize: 16),
                                                    ),
                                                  ),
                                                ))
                                          ],
                                        ),
                                      ),
                                    ));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      eventsList[index]['logo']['url'],
                                      width: MediaQuery.of(context).size.width -
                                          64,
                                      fit: BoxFit.fill,
                                      height: 100,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 24.0),
                                  child: Text(
                                    eventsList[index]['name']['text'] == null
                                        ? ''
                                        : eventsList[index]['name']['text'],
                                    style: GoogleFonts.alata(fontSize: 18),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Color(0xff3F38DD)
                                                .withOpacity(0.17),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.calendar_today,
                                            color: Color(0xff3F38DD),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${DateTime.parse(eventsList[index]['start']['local']).day} ${DateFormat('MMMM').format(DateTime.parse(eventsList[index]['start']['local']))}, ${DateTime.parse(eventsList[index]['start']['local']).year}",
                                              style: GoogleFonts.alata(
                                                  fontSize: 14),
                                            ),
                                            Text(
                                                "${DateFormat('EEEE').format(DateTime.parse(eventsList[index]['start']['local']))}, ${DateTime.parse(eventsList[index]['start']['local']).hour}:${DateTime.parse(eventsList[index]['start']['local']).minute}",
                                                style: GoogleFonts.alata(
                                                    color: Color(0xff767676),
                                                    fontSize: 14))
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  }))
        ],
      ),
    ));
  }
}
