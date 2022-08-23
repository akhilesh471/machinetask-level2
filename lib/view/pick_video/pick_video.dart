import 'dart:developer';
import 'dart:io';

import 'package:demo_app/controller/login_controller.dart';
import 'package:demo_app/controller/video_controller.dart';
import 'package:demo_app/model/video_mode/video_model.dart';
import 'package:demo_app/view/video_list/video_list.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class PickVideo extends StatefulWidget {
  PickVideo({Key? key}) : super(key: key);

  @override
  State<PickVideo> createState() => _PickVideoState();
}

class _PickVideoState extends State<PickVideo> {
  VideoController videoController = Get.put(VideoController());
  File? _video;
  VideoPlayerController? _videoPlayerController;
  final picker = ImagePicker();


  _pickVideo() async {
    var pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    _video = File(pickedFile!.path);

    _videoPlayerController =  VideoPlayerController.file(_video!)
      ..initialize().then((_) {
        setState(() {});
        _videoPlayerController!.play();
      });
  }

  @override
  Widget build(BuildContext context) {
// videoController.data = videoController.observableBox!.values.toList();
    // log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>${videoController.data.length.toString()}");
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              if (_video != null)
                _videoPlayerController!.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: 0.9,
                        child: VideoPlayer(_videoPlayerController!),
                      )
                    : Container()
              else
                Text(
                  "Click on Pick Video to select video",
                  style: TextStyle(fontSize: 18.0),
                ),
                
              ElevatedButton(
                onPressed: () {
                  _pickVideo();
                },
                child: Text("Pick Video From Gallery"),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [ ElevatedButton(
                  onPressed: () {
                    if(_video==null){
                    Fluttertoast.showToast(msg: 'Please choose a video from gallery');
                      return null;
                    }
                    var model =
                        VideoModel(DateTime.now().microsecond, _video!.path);
                    videoController.addVideo(model: model);
                    videoController.update();
                    _video==null;
                  },
                  child: Text('Submit')),
              ElevatedButton(
                onPressed: () {
                  Get.to(() => VideoList());
                },
                child: Text('view videos'),
              )],),
             
            ],
          ),
        ),
      ),
    );
  }
}
