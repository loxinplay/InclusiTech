import 'package:cohort_messenger/pages/preferences_page.dart';
import 'package:cohort_messenger/services/auth/login_or_register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import '../../pages/default_page.dart';
// import '../../pages/home_page.dart';
import '../../pages/preferences_page.dart';
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          // user is logged in
if(snapshot.hasData){
  return const PreferencesPage();
}else {
  // user is not logged in
  return const LoginOrRegister();
}
        },
      ),
    );
  }
}
