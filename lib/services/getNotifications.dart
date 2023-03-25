import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:yuva_again/services/yourChannels.dart';

getNotifications() async {
  var auth = FirebaseAuth.instance;
  String uid = auth!.currentUser!.uid;
  List channels = await yourChannels(uid);

  List newlist = [];
  final snapshot = await FirebaseDatabase.instance.ref('notifications').get();
  var data = Map<String, dynamic>.from(snapshot.value as dynamic);
  print(data);
  for (int i = 0; i < channels.length; i++) {
    var ele = channels[i];
    var oneinterest = data[ele.toString().trim()];
    for (int j = 0; j < oneinterest.keys.length; j++) {
      var eventsofoneinterest = oneinterest[oneinterest.keys.toList()[j]];
      newlist.add(eventsofoneinterest);
    }
  }
  print(newlist);
  return newlist;
}
