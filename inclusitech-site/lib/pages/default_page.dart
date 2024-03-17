import 'package:flutter/material.dart';

class DefaultPage extends StatefulWidget {
  const DefaultPage({super.key});

  @override
  State<DefaultPage> createState() => _DefaultPageState();
}

class _DefaultPageState extends State<DefaultPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SizedBox(width: 150,
          child: ListView.separated(
              itemBuilder: (BuildContext context, int index){
                return SizedBox(height: 5,);
              },
              separatorBuilder: (BuildContext context, int index){
                return GestureDetector(
                  onTap: (){
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Container(
                    child: Row(
                      children: [
                        AnimatedContainer(duration: Duration(milliseconds: 70),
                        height: (selectedIndex == index) ? 50 : 0,
                        width: 5,
                        color: Colors.blue,
                        ),
                        Expanded(child: Container(
                          color: (selectedIndex == index) ? Colors.blueGrey.withOpacity(0.2) : Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                            child: Icon(Icons.home),
                          ),
                        ))
                      ],
                    ),
                  ),
                );
              },
              itemCount: 4,
          ),
          ),
          Expanded(child: Container())

        ],
      ),
    );
  }
}
