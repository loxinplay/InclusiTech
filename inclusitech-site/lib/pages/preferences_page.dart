import 'package:cohort_messenger/pages/tabs/hometab.dart';
import 'package:cohort_messenger/pages/tabs/lessons.dart';
import 'package:cohort_messenger/pages/tabs/session.dart';
import 'package:cohort_messenger/pages/tabs/settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cohort_messenger/services/auth/auth_service.dart';
class PreferencesPage extends StatefulWidget {
  const PreferencesPage({super.key});

  @override
  State<PreferencesPage> createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void signOut() {
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.signOut();
// Another way to sign out if you used stateless widget
    // FirebaseAuth.instance.signOut();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child:Scaffold(
        appBar: AppBar(

        ),
        body: const Column(
          children: [
            TabBar(
                tabs: [
              Tab(icon: Icon(
                Icons.text_snippet_sharp, color: Colors.deepPurple,
              ),
              ),

                  Tab(icon: Icon(
                    Icons.play_lesson_rounded, color: Colors.deepPurple,
                  ),
                  ),

                  Tab(icon: Icon(
                    Icons.cast_for_education_outlined, color: Colors.deepPurple,
                  ),
                  ),
                  Tab(icon: Icon(
                    Icons.account_circle_rounded, color: Colors.deepPurple,
                  ),
                  ),

            ]
            ),
            Expanded(
              child: TabBarView(children: [
                HomeTab(),
                Lessons(),
                Session(),
                Settings(),
              ]
              ),
            ),

          ],
        ),
      ),
    );
  }
}
