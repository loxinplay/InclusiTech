import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'package:cohort_messenger/components/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Session extends StatefulWidget {

  const Session({super.key});

  @override
  State<Session> createState() => _SessionState();
}


class _SessionState extends State<Session> {

YoutubePlayerController _ytcontrol = YoutubePlayerController(
    initialVideoId: 'NybHckSEQBI',
  flags: YoutubePlayerFlags(
    autoPlay: true, // Set to true for automatic playback
    mute: false,   // Set to true to mute the video
  ),

);
  final srController = TextEditingController();

String warning = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
        
        
        
                // text about the session
                const Text("Start the session and watch videos."
                "AI will help you to find the best videos from Youtube!",
                  style: TextStyle(fontSize: 30,),
                ),
        
                const SizedBox(height: 30,),
                // button to start watching chosen video
                myTextField(hintText: 'Search youtube videos', obscureText: false, controller: srController),
                const SizedBox(height: 20,),
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
                      icon: Icon(Icons.find_in_page_outlined),
                  ),
        
                // user starts using his camera, and Opencv AI controls his moves
                const SizedBox(height: 30,),
        Container(
          height: 600, // Adjust height and width as needed
          width: 1067,
          child: YoutubePlayer(controller: _ytcontrol,

          ),
        )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

