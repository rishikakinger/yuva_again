import 'package:firebase_database/firebase_database.dart';

getMyChannels(uid) async {
  final snapshot = await FirebaseDatabase.instance.ref('users/$uid').get();
  if (snapshot.exists) {
    var data = Map<String, dynamic>.from(snapshot.value as dynamic);

    return {
      'name': data['Name'],
      'interests': [
        ...data['Current Interests']
            .substring(1, data['Current Interests'].length - 1)
            .split(","),
        //     ...data['Future Interests']
        //         .substring(1, data['Future Interests'].length - 1)
        //         .split(",")
      ].toSet().toList()
    };
  }
}
