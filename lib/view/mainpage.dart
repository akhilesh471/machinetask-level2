import 'package:demo_app/view/current_location/current_location.dart';
import 'package:demo_app/view/pick_video/pick_video.dart';
import 'package:flutter/material.dart';
int? currentIndex;
class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
Widget build(BuildContext context) {
    currentIndex=0;
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey),
                  tabs:const [
                    Tab(text: 'Choose Video'),
                    Tab(text: 'Current Location'),
                  ],),
            ),
            body: TabBarView(children: [PickVideo(), CurrentLocation()])));
  }
}