import 'package:firebase_core/firebase_core.dart';
import 'dart:async';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart';
import 'package:text_to_speech/text_to_speech.dart';
import 'package:yuva_again/screens/bottom_navigation_bar/profile.dart';
import 'package:yuva_again/screens/games/games.dart';
import 'package:yuva_again/screens/hobbies/choice.dart';
import 'package:yuva_again/screens/hobbies/hobbies.dart';
import 'package:yuva_again/screens/bottom_navigation_bar/notifications.dart';
import 'package:yuva_again/screens/voiceChannels/voiceChannels.dart';
import 'package:alan_voice/alan_voice.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:yuva_again/widgets/header.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import'package:yuva_again/screens/home.dart';
import 'package:flutter/src/widgets/framework.dart';

class CallPage extends StatelessWidget {
  const CallPage({Key? key, required this.callID}) : super(key: key);
  final String callID;


  @override
  Widget build(BuildContext context) {

    return ZegoUIKitPrebuiltCall(
      appID: 1329857941, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
      appSign: "6fae8fed0a96ea745fb9f4789ad5c3e51c073568ea8df0f69ddb5c8501a84a66", // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
      userID: '2',
      userName: 'meg',
      callID: callID,
      // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
        ..onOnlySelfInRoom = (context) => Navigator.of(context).pop(),
    );
  }
}

