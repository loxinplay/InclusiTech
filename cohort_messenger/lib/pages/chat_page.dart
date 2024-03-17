
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/my_text_field.dart';
import '../services/chat/chat_service.dart';

class ChatPage extends StatefulWidget {
  final String receiveUserEmail;
  final String receiveUserID;
  const ChatPage({super.key,
    required this.receiveUserEmail,
    required this.receiveUserID
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    // only send them where message exists
    if(_messageController.text.isNotEmpty){
      await _chatService.sendMessage(widget.receiveUserID, _messageController.text);
      // clear the controller after sending
      _messageController.clear();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.receiveUserEmail),),
      body: Column(
        children: [
          //messages
          Expanded(child: _buildMessageList(),
          ),
          // user input
          _buildMessageInput(),
        ],
      ),
    );
  }
  // build message list
Widget _buildMessageList(){
    return StreamBuilder(stream: _chatService.getMessages(
        widget.receiveUserID,
        _firebaseAuth
            .currentUser!
            .uid
    ),
        builder: (context,snapshot) {
      if(snapshot.hasError){
        return Text("Error${snapshot.error}");
      }
      if(snapshot.connectionState == ConnectionState.waiting){
        return const Text("loading..");
      }
      return ListView(
        children: snapshot.data!
            .docs
            .map((document) => _buildMessageItem(document))
            .toList(),
      );
        },
    );
}
// build message item
  Widget _buildMessageItem(DocumentSnapshot document){
    Map<String,dynamic> data = document.data() as Map<String, dynamic>;
    // align message items
    var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
    ? Alignment.centerRight : Alignment.centerLeft;
    return Container(
      decoration: BoxDecoration(color: Colors.purple),
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(

          children: [
            Text(data['senderEmail']),
            Text(data['message']),
          ],
        ),
      ),
    );

  }


// build message input
Widget _buildMessageInput(){
return Row(
  children: [
    // Textfield
    Expanded(
      child: myTextField(
        hintText: "Enter message",
        controller: _messageController,
        obscureText: false,
      ),
    ),
    IconButton(
        onPressed: sendMessage,
        icon: const Icon(Icons.arrow_upward_rounded,
          size: 40,
        ),
    )
  ],
);

}
}
