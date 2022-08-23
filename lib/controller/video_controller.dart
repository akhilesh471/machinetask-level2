import 'dart:developer';
import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:demo_app/model/video_mode/video_model.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:video_player/video_player.dart';

class VideoController extends GetxController {
   VideoPlayerController? videoPlayerController;
  Future addVideo({required VideoModel model})async{

    final box=await Hive.openBox<VideoModel>('video');    
    box.put(model.id, model);
    update();
  getAllVideos();
  }

List<VideoModel> data=[];

Future getAllVideos()async{  
  print('calledFunction');
 final box=await Hive.openBox<VideoModel>('video');
 data= box.values.toList();
   update();
//  print(data.);
}

Future removeVideo({required int id})async{
  final box=await Hive.openBox<VideoModel>('video');
  box.delete(id);
getAllVideos();
}


getVideo({required VideoModel model}) {
   videoPlayerController=VideoPlayerController.file(File(model.video!))..initialize().then((_) {
videoPlayerController!.play();
update();
    });
  
}

@override
  void onInit() {
 getAllVideos();

    super.onInit();
  }
}