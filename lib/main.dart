import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pationt/provider/prov.dart';
import 'package:pationt/view/doctor.dart';
import 'package:pationt/view/search.dart';
import 'package:pationt/view/signin.dart';
import 'package:pationt/view/signup.dart';
import 'package:provider/provider.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

//

import 'package:pationt/view/home.dart';
import 'package:pationt/view/notification.dart';
import 'package:pationt/view/profile.dart';
import 'package:pationt/view/profile_doctor_visit.dart';
import 'package:pationt/view/quistions.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory dir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(dir.path);
  await Hive.openBox('id');
  await Hive.openBox('name');
  await Hive.openBox('phone');
  await Hive.openBox('pass');
  await Hive.openBox('age');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
   
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    late Box idbox = Hive.box("id");
    return ChangeNotifierProvider(
        create: (context) {
          return control();
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            'signin': (context) => signin(),
            'signup': (context) => signup(),
            'doctor': (context) => doctor(),
            'search': (context) => search(),
            'profile':(context) => profile(),
            'home':(context) => home(),
            'profile_doctor_visit':(context) =>profile_doctor_visit(),
            'quistion':(context) => quistion(),
            'notification':(context) => notification(),
          },
          
          home: idbox.get('id') !=null&&idbox.get('id') !=''?doctor():signin(),
        ));
  }
}
