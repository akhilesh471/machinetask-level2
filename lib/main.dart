import 'package:demo_app/model/video_mode/video_model.dart';
import 'package:demo_app/view/login_page/login.dart';
import 'package:demo_app/view/mainpage.dart';
import 'package:demo_app/view/pick_video/pick_video.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
bool? isLogged;
Future  main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  if(!Hive.isAdapterRegistered(VideoModelAdapter().typeId)){
    Hive.registerAdapter(VideoModelAdapter());
  }
  final prefs=await SharedPreferences.getInstance();
  isLogged= prefs.getBool('flag');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      
        primarySwatch: Colors.blue,
      ),
      home: isLogged==true?MainPage():
       Login()
    );
  }
}

