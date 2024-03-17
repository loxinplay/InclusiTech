import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cohort_messenger/services/auth/auth_service.dart';
class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
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
    body: SafeArea(
      child: Center(
        child: Column(
          children: [
            // info about the account (email, diagnosis)

            SizedBox(height: 50,),
            // log out button
            IconButton(onPressed: signOut, icon: Icon(Icons.logout))
          ],
        ),
      ),
    ),
    );
  }
}
