

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Session extends StatefulWidget {

  const Session({super.key});

  @override
  State<Session> createState() => _SessionState();
}


class _SessionState extends State<Session> {

String warning = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              // text about the session
              const Text("Start the session and watch chosen video."
              "Our AI will help you to keep your focus!",
                style: TextStyle(fontSize: 30,),
              ),

              const SizedBox(height: 30,),
              // button to start watching chosen video
                IconButton(
                     onPressed: () async {
                       // This example will fetch a random quote from the
                       // dummyjson.com service...
                       final url = Uri.http('127.0.0.1:5000', '/');

                       // You can hover your cursor over the .get() method to learn more about it, or,
                       // right click it and select 'Go to Definition' to view the source.
                       final response = await http.get(url);

                       // ...and print the quote if the fetch was successful.
                       if (response.statusCode == 200) {
                         final json = convert.jsonDecode(response.body);
                         print(json);
                         warning = json;

                       } else {
                         print('Request failed with code: ${response.statusCode}.');
                       }
                     },
                    icon: Icon(Icons.video_camera_front_rounded),
                ),
              // user starts using his camera, and Opencv AI controls his moves
              const SizedBox(height: 30,),

            ],
          ),
        ),
      ),
    );
  }
}

