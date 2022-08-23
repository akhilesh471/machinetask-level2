import 'package:demo_app/controller/currentlocation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CurrentLocation extends StatelessWidget {
  CurrentLocation({Key? key}) : super(key: key);
  CurrentLocationController currentLocationController =
      Get.put(CurrentLocationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(mainAxisAlignment: MainAxisAlignment.start,
        children: [
            

            Row(
              children: [
                Obx(() => Text(currentLocationController.address.value)),
              ],
            ),
        Row(
            children: [
              Obx(() => Text(currentLocationController.latitude.value)),
            ],
        ),
            Row(
              children: [
                Obx(() => Text(currentLocationController.longitude.value)),
              ],
            ),
        ],
      ),
          )),
    );
  }
}
