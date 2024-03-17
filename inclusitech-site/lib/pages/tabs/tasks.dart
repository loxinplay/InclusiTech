// import 'package:cohort_messenger/components/my_text_field.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
//
// class Tasks extends StatelessWidget {
//   Tasks({super.key,});
//   final ansController = TextEditingController();
//   final ans2Controller = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             SizedBox(height: 20,),
//             Text("  Pass tests and check your knowledges!", style: TextStyle(fontSize: 30),),
//             SizedBox(height: 40,),
//             Text("Computer science basics test:", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
//             const SizedBox(height: 10,),
//             Text("1. True of False? Computer Science is a science about how computers work and integrate in real world",
//             style: TextStyle(fontSize: 30),
//             ),
//              SizedBox(height: 30,),
//             Row(
//
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 const SizedBox(width: 600,),
//                 SafeArea(
//                   child: GestureDetector(
//                     onTap: (){
//
//                     },
//                     child: Container(
//                       width: 100,
//                       height: 40,
//                       alignment: Alignment.center,
//                       child:  Text("True", textAlign: TextAlign.center, style: TextStyle(fontSize: 20),),
//                     decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(10.0),),
//
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 25,),
//                 GestureDetector(
//                   onTap: (){
//
//                   },
//                   child: Container(
//                     width: 100,
//                     height: 40,
//                     alignment: Alignment.center,
//                       child:  Text("False", textAlign: TextAlign.center,style: TextStyle(fontSize: 20),),
//                     decoration: BoxDecoration(color: Colors.red,
//                         borderRadius: BorderRadius.circular(10.0),
//
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             // TextButton(onPressed: () {} , child: Text("Linear equations",)),
//             // const SizedBox(height: 20,),
//             // TextButton(onPressed: () {} , child: Text("Organic chemistry")),
//             // const SizedBox(height: 20,),
//             // TextButton(onPressed: () {} , child: Text("Computer science")),
//             // const SizedBox(height: 20,),
//
//             // TextButton(onPressed: () {} , child: Text("The Great depression")),
//             // const SizedBox(height: 20,),
//             // TextButton(onPressed: () {} , child: Text("Ecosystems and biological chains")),
//             // const SizedBox(height: 20,),
//             const SizedBox(height: 20,),
//             Text("Write 2 basic aspects of computer architecture:"
//                 ,
//               style: TextStyle(fontSize: 30),
//             ),
//             SizedBox(height: 30,),
//             myTextField(hintText: 'Answer...',
//                 obscureText: false,
//                 controller: ansController
//             ),
//
//             const SizedBox(height: 20,),
//             Text("Who is the founder of Computer Science",
//
//               style: TextStyle(fontSize: 30),
//             ),
//             SizedBox(height: 30,),
//             myTextField(hintText: 'Answer...',
//                 obscureText: false,
//                 controller: ans2Controller
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class Tasks extends StatefulWidget {
  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  // Define questions and answers (assuming these are tasks now)
  final List<Map<String, dynamic>> tasks = [
    {
      "type": "true/false", // Task type
      "question": "The Earth is flat.",
      "answer": false,
      "selectedValue": null, // Add a field to track user selection for each task
    },
    {
      "type": "a/b/c/d", // Task type
      "question": "What is the capital of France?",
      "answer": "a", // Option index (0 for A)
      "options": ["Paris", "London", "Berlin", "Madrid"],
      "selectedValue": null, // Add a field to track user selection for each task
    },
    {
      "type": "true/false",
      "question": "Water boils at 100°C.",
      "answer": true,
      "selectedValue": null, // Add a field to track user selection for each task
    },
  ];

  // Keep track of score
  int correctAnswers = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Test'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Loop through tasks and display them
                for (int i = 0; i < tasks.length; i++)
                  buildTask(tasks[i], i), // Pass index for selection handling
                ElevatedButton(
                  onPressed: () => checkAnswers(),
                  child: Text('Submit Test'),
                ),
                Text('Correct Answers: $correctAnswers/${tasks.length}'), // Display score
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Build a single task widget
  Widget buildTask(Map<String, dynamic> task, int index) {
    if (task['type'] == "true/false") {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(task['question']),
          Row(
            children: [
              Radio(
                value: true,
                groupValue: task['selectedValue'],
                onChanged: (value) => setState(() => task['selectedValue'] = value),
              ),
              Text('True'),
              Radio(
                value: false,
                groupValue: task['selectedValue'],
                onChanged: (value) => setState(() => task['selectedValue'] = value),
              ),
              Text('False'),
            ],
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(task['question']),
          for (int i = 0; i < task['options'].length; i++)
            RadioListTile(
              title: Text(task['options'][i]),
              value: i,
              groupValue: task['selectedValue'],
              onChanged: (value) => setState(() => task['selectedValue'] = value),
            ),
        ],
      );
    }
  }

  // Check answers and calculate correct ones
  void checkAnswers() {
    correctAnswers = 0;
    for (int i = 0; i < tasks.length; i++) {
      if (tasks[i]['type'] == "true/false") {
        if (tasks[i]['selectedValue'] == tasks[i]['answer']) {
          correctAnswers++;
        }
      } else {
        if (tasks[i]['selectedValue'] == tasks[i]['answer']) {
          correctAnswers++;
        }
      }
    }
    setState(() {}); // Update UI with score
  }
}
