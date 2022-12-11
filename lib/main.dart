import 'package:flutter/material.dart';
import 'package:grocery_list/pages/homePage.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {

  // Initialize Hive Database
  await Hive.initFlutter();

  // Open a box
  var box = await Hive.openBox('listBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const String myTitle = "Shopping List";
    return MaterialApp(
      title: myTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: myTitle),
    );
  }
}
