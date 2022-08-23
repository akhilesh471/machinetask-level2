import 'package:demo_app/controller/login_controller.dart';
import 'package:demo_app/controller/video_controller.dart';

import 'package:demo_app/view/pick_video/pick_video.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
   Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
LoginController loginController=Get.put(LoginController());
 
  @override
  Widget build(BuildContext context) {
    print('object');
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async{
                    final isLogged= await loginController.signInWithGoogle();
                    final prefs= await SharedPreferences.getInstance();
                    prefs.setBool('flag', true);
                    if(isLogged==true){
                      Get.to(()=>PickVideo());
                    }
                },
                child: const Text('Login / Signup with Google'),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
