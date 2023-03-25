import 'package:firebase_database/firebase_database.dart';

treeincrement(uid) async {
  DatabaseReference ref = FirebaseDatabase.instance.ref('users/$uid');
  final snapshot = await ref.get();
  if (snapshot.exists) {
    var data = Map<String, dynamic>.from(snapshot.value as dynamic);
    ref.update(
        {"treeScore": data['treeScore'] != null ? data['treeScore'] + 5 : 5});
  }
}
