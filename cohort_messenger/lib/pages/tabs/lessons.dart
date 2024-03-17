import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tflite/tflite.dart';

import '../../main.dart';

class Lessons extends StatefulWidget {
  const Lessons({super.key});

  @override
  State<Lessons> createState() => _LessonsState();
}

class _LessonsState extends State<Lessons> {
  CameraImage? cameraImage;
  CameraController? cameraController;
  String output = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadCamera();
    loadmodel();
  }

  loadCamera(){
    cameraController = CameraController(
        cameras![0],
        ResolutionPreset.medium,
    );
cameraController!.initialize().then((value){
  if(!mounted){
    return;
  }else{
    setState(() {
      cameraController!.startImageStream((imageStream) {
        cameraImage = imageStream;
        runModel();
      }
      );
    });
  }
    }
    );
  }
  runModel() async{
    if(cameraImage != null){
      var predictions = await Tflite.runModelOnFrame(
          bytesList: cameraImage!.planes.map(
              (plane) {
                return plane.bytes;
              }).toList(),
      imageHeight: cameraImage!.height,
        imageWidth: cameraImage!.width,
        imageMean: 127.5,
        imageStd: 127.5,
        rotation: 90,
        numResults: 2,
        threshold: 0.1,
        asynch: true
      );
      predictions!.forEach((element){
        setState(() {
          output = element['label'];
        });
      });
    }
  }
  loadmodel() async{
    await Tflite.loadModel(
        model: "assets/model.tflite",
    labels: "assets/labels.txt"
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Container(
              height: MediaQuery.of(context).size.height*0.7,
              width: MediaQuery.of(context).size.height*0.7,
              child: !cameraController!.value.isInitialized?
              Container():
                  AspectRatio(aspectRatio: cameraController!.value.aspectRatio,
                  child: CameraPreview(cameraController!),
                  ),
            ),
          ),
          const SizedBox(height: 20,),

          Text(output, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
        ],

      )

    );
  }
}
