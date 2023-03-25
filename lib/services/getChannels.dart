import 'package:firebase_database/firebase_database.dart';

getsChannels() async {
  DatabaseReference ref = FirebaseDatabase.instance.ref('channels');
  final snapshot = await ref.get();
  if (snapshot.exists) {
    var data = Map<String, dynamic>.from(snapshot.value as dynamic);
    return data.keys.toList();
  }
}
