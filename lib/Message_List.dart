import 'package:location_tracker/FirebaseDAO.dart';

class MessageList {
  final messageDao = MessageDAO();

  void _sendMessage() {
    if (_canSendMessage()) {
      final message = Message(_messageController.text, DateTime.now());
      widget.messageDao.saveMessage(message);
      _messageController.clear();
      setState(() {});
    }
  }
}
