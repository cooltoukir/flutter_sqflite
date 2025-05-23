import 'package:flutter/material.dart';
import 'package:flutter_sqflite/presentation/controllers/quran_controller.dart';
import 'package:flutter_sqflite/presentation/controllers/todo_controller.dart';
import 'package:flutter_sqflite/presentation/pages/quran_page.dart';
import 'package:flutter_sqflite/presentation/pages/todo_page.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
  Get.put(TodoController());
  Get.put(QuranController());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: QuranPage(),
    );
  }
}
