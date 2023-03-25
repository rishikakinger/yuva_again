import 'package:firebase_database/firebase_database.dart';

yourChannels(uid) async {
  final snapshot = await FirebaseDatabase.instance.ref('users/$uid').get();
  if (snapshot.exists) {
    var data = Map<String, dynamic>.from(snapshot.value as dynamic);

    return [
      ...data['Current Interests']
          .substring(1, data['Current Interests'].length - 1)
          .split(","),
      ...data['Future Interests']
          .substring(1, data['Future Interests'].length - 1)
          .split(",")
    ].toSet().toList();
  }
}
