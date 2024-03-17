
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cohort_messenger/services/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'chat_page.dart';


class HomePage extends StatefulWidget {
  HomePage({super.key, });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // instance of auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

// sign user out
  void signOut() {
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.signOut();
// Another way to sign out if you used stateless widget
    // FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Talk to someone..",),
      actions: [
        IconButton(
          onPressed: signOut,
          icon: Icon(Icons.logout))
        ],
      ),
      body: _buildUserList(),
    );
  }

  // buid a list of users except current user
Widget _buildUserList(){
  return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder:(context,snapshot){
        if (snapshot.hasError){
          return const Text('error');
        }
        if(snapshot.connectionState == ConnectionState.waiting) {
          return const Text('loading..');
        }
        return ListView(
          children: snapshot.data!.docs
              .map((doc) => _buildUserListItem(doc))
              .toList(),
        );
      },
  );
}

// build individual user list items
Widget _buildUserListItem(DocumentSnapshot document){
  Map<String, dynamic> data = document.data()! as Map<String,dynamic>;
  // display all users except current
  if(_auth.currentUser!.email != data['email']){
    return ListTile(
      title: Text(data['email']),
      onTap: (){
        // pass the clicked users UID to chat
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(
              receiveUserEmail: data['email'],
              receiveUserID: data['uid'],
            ),
        ),
        );
      },
    );
  }else{
    // return empty container
    return Container();
  }
}
}


