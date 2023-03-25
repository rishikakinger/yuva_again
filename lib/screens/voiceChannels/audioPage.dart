import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:yuva_again/widgets/header.dart';

class Audio extends StatefulWidget {
  const Audio({Key? key}) : super(key: key);

  @override
  State<Audio> createState() => _AudioState();
}

class _AudioState extends State<Audio> {
  String channelName = "Knitting";
  String token = "";
  static const appId = "5ef9b48c22384b14bf4faccc9d250bc0";
  int uid = 0; // uid of the local user
  bool mute = false;
  int? _remoteUid; // uid of the remote user
  bool _isJoined = false; // Indicates if the local user has joined the channel
  late RtcEngine agoraEngine; // Agora engine instance
  @override
  void initState() {
    super.initState();//initialize when user opens
    // Set up an instance of Agora engine
    init_wrapper();
  }

  init_wrapper() async {
    final snapshot = await FirebaseDatabase.instance.ref('token').get();
    var data = Map<String, dynamic>.from(snapshot.value as dynamic);
    setState(() {
      token = data['Knitting'];
    });
    setupVoiceSDKEngine();
  }

  Future<void> setupVoiceSDKEngine() async {
    // retrieve or request microphone permission
    await [Permission.microphone].request();

    //create an instance of the Agora engine
    agoraEngine = createAgoraRtcEngine();
    await agoraEngine.initialize(const RtcEngineContext(appId: appId));

    // Register the event handler
    agoraEngine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          setState(() {
            _isJoined = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          setState(() {
            _remoteUid = remoteUid;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          setState(() {
            _remoteUid = null;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
            children: [
              Header(
                heading: "Voice Channels",
              ),
              // Status text
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 32.0),
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              offset: Offset(0, 4),
                              blurRadius: 4)
                        ],
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xfffbf2ce)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16.0, 0, 16),
                          child: Text(
                            "Reading",
                            style: GoogleFonts.alata(fontSize: 30),
                          ),
                        ),
                        Image.asset('assets/images/events.png'),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 32.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.call_end,
                                    size: 42,
                                  )),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.mic,
                                    size: 42,
                                  )),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.volume_mute,
                                    size: 42,
                                  )),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.person,
                                    size: 42,
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }

  void join() async {
    // Set channel options including the client role and channel profile
    ChannelMediaOptions options = const ChannelMediaOptions(
      clientRoleType: ClientRoleType.clientRoleBroadcaster,
      channelProfile: ChannelProfileType.channelProfileCommunication,
    );

    await agoraEngine.joinChannel(
      token: token,
      channelId: channelName,
      options: options,
      uid: uid,
    );
  }

  void leave() {
    setState(() {
      _isJoined = false;
      _remoteUid = null;
    });
    agoraEngine.leaveChannel();
  }

  Widget _status() {
    String statusText;

    if (!_isJoined)
      statusText = 'Join a channel';
    else if (_remoteUid == null)
      statusText = 'Waiting for a remote user to join...';
    else
      statusText = 'Connected to remote user, uid:$_remoteUid';

    return Text(
      statusText,
      style: GoogleFonts.montserrat(),
    );
  }

  @override
  void dispose() async {
    await agoraEngine.leaveChannel();
    super.dispose();
  }
}