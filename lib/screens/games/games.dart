import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:yuva_again/widgets/header.dart';

class Games extends StatefulWidget {
  final url;
  const Games({Key? key, this.url}) : super(key: key);

  @override
  State<Games> createState() => _GamesState();
}

class _GamesState extends State<Games> {
  bool isLoading = true;
  bool hasConnection = true;
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      checkUserConnection();
    });

    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Header(
              heading: widget.url ==
                      "https://www.seniorsonline.vic.gov.au/services-information/games"
                  ? "games"
                  : 'events',
            ),
          ),
          Expanded(
            child: WebView(
              initialUrl: widget.url,
              javascriptMode: JavascriptMode.unrestricted,
              onPageFinished: (finish) {
                setState(() {
                  isLoading = false;
                });
              },
            ),
          ),
        ],
      )),
    );
  }

  Future<void> checkUserConnection() async {
    try {
      final result = await InternetAddress.lookup("google.com");
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          hasConnection = true;
        });
      }
    } catch (error) {
      setState(() {
        hasConnection = false;
      });
    }
  }
}
