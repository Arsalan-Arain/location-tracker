import 'package:firebase_database/firebase_database.dart';

import 'FirebaseDataModel.dart';

class MessageDAO {
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.reference().child('messages');

  void saveMessage(Message message) {
    _databaseReference.push().set(message.toJson());
  }

  Query getMessages() {
    return _databaseReference;
  }
}
