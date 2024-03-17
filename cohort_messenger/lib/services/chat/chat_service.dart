import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cohort_messenger/model/message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatService extends ChangeNotifier{

  // get instance of firebase auth and firestore

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  // SEND MESSAGE
Future<void> sendMessage(String receiverId, String message) async{
  // get current user
final String currentUserId = _firebaseAuth.currentUser!.uid;
final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
final Timestamp timestamp = Timestamp.now();

  // create a new message
Message newMessage = Message(
    senderId: currentUserId,
    senderEmail: currentUserEmail,
    receiverId: receiverId,
    message: message,
    timestamp: timestamp
);

  // construct chat room id for both
List<String> ids = [currentUserId, receiverId];
ids.sort(); // sort the ids (chat rooms are have same id for two people)
  String chatRoomId = ids.join("_"); // combine the ids to identificate

  // add new message to database
await _fireStore.collection('chat_room')
    .doc(chatRoomId)
    .collection('messages')
    .add(newMessage.toMap());
}


// RECEIVE MESSAGE
Stream<QuerySnapshot> getMessages(String userId,String otherUserId){
  // construct chat room id from the user ids
  List<String> ids = [userId, otherUserId];
  ids.sort();
  String chatRoomId = ids.join("_");

  return _fireStore
      .collection('chat_rooms')
      .doc('chatRoomId')
      .collection('messages')
      .orderBy('timestamp', descending: false)
      .snapshots();
}

}