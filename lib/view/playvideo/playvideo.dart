import 'dart:io';

import 'package:demo_app/controller/video_controller.dart';
import 'package:demo_app/model/video_mode/video_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class PlayVideo extends StatefulWidget {
  PlayVideo({Key? key, required this.model}) : super(key: key);
  final VideoModel model;
  @override
  State<PlayVideo> createState() => _PlayVideoState();
}

class _PlayVideoState extends State<PlayVideo> {
   VideoController? videoController;
  @override
  void initState() {
    videoController = Get.find<VideoController>()..getVideo(model: widget.model);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // videos(url: widget.model.video!);
    return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
            child: GetBuilder<VideoController>(init: VideoController(),builder: (videoController) {
          return videoController.videoPlayerController!.value.isInitialized
              ? Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: AspectRatio(
                    aspectRatio: 0.9,
                    child: VideoPlayer(videoController.videoPlayerController!),
                  ),
                )
              : SizedBox();
        })));
  }

//  videos({required String url}) {
//     _videoPlayerController=  VideoPlayerController.file(File(url))
//       ..initialize().then((value) {
//         setState(() {
//           _videoPlayerController!.play();
//         });
//       });
//   }
}
