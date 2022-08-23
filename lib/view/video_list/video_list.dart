import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:demo_app/controller/video_controller.dart';
import 'package:demo_app/model/video_mode/video_model.dart';
import 'package:demo_app/view/playvideo/playvideo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class VideoList extends StatelessWidget {
  VideoList({Key? key}) : super(key: key);
  final videoController = Get.find<VideoController>();

  @override
  Widget build(BuildContext context) {
    log(videoController.data.length.toString());
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: GetBuilder<VideoController>(init: VideoController(),builder: (controller) {
           
         
            return ListView.builder(
                itemCount: controller.data.length,
                itemBuilder: (context, index) {
                  log(controller.data[index].video!);
                  return FutureBuilder(
                      future: thumbnail(controller.data[index].video!),
                      builder: (context, AsyncSnapshot<String?> snapshot) {
                        return snapshot.hasData
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Get.to(PlayVideo(
                                      model: controller.data[index],
                                    ));
                                  },
                                  child: Container(
                                    // color: Colors.grey,
                                    height: 250,
                                    // width: 40,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  
                                                  videoController.removeVideo(id: videoController.data[index].id!);
                                                },
                                                icon: Icon(Icons.delete))
                                          ],
                                        ),
                                        Stack(
                                          children: [
                                            SizedBox(
                                              height: 190,
                                              width: 300,
                                              child: Image.file(
                                                File(snapshot.data!),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            Positioned(left: 110,top: 50,child: Icon(Icons.play_arrow,size: 80,))
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox();
                      });
                });
          }
          )),
    );
  }

  Future<String> thumbnail(String path) async {
    var fileName = await VideoThumbnail.thumbnailFile(
      video: path,
      // thumbnailPath: (await getTe),
      imageFormat: ImageFormat.PNG,
      maxHeight: 200,
      // maxWidth: ,// specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
      quality: 74,
    );
    return fileName!;
  }
}

// _pickVideo() async {
//     var pickedFile = await picker.pickVideo(source: ImageSource.gallery);
//     _video = File(pickedFile!.path);
//   print(_video!.path);
//     _videoPlayerController = await VideoPlayerController.file(_video!)
//       ..initialize().then((_) {
//         setState(() {});
//         _videoPlayerController!.play();
//       });
//   }

