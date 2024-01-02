import 'package:flutter/material.dart';
import 'package:flutter_database/screens/home_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'data/task.dart';
import 'data/task_type.dart';
import 'data/type_enum.dart';



void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(TaskTypeAdapter());
  Hive.registerAdapter(TaskTypeEnumAdapter());
  var box3 = await Hive.openBox<Task>('taskBox');

  runApp(Application());
}

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: "SM"),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
