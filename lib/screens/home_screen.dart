import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_database/screens/add_task_screen.dart';
import 'package:flutter_database/widgets/task_widget.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../data/task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var taskBox = Hive.box<Task>("taskBox");
  bool isFabVisbile = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      body: Center(
        child: ValueListenableBuilder(
          valueListenable: taskBox.listenable(),
          builder: (context, value, child) =>
              NotificationListener<UserScrollNotification>(
            onNotification: (notification) {
              setState(
                () {
                  if (notification.direction == ScrollDirection.forward) {
                    isFabVisbile = true;
                  } else if (notification.direction ==
                      ScrollDirection.reverse) {
                    isFabVisbile = false;
                  }
                },
              );
              return true;
            },
            child: ListView.builder(
              itemCount: taskBox.values.length,
              itemBuilder: (context, index) {
                var task = taskBox.values.toList()[index];
                // print(task.taskType.title);
                return Dismissible(
                    key: UniqueKey(),
                    onDismissed: (direction) {
                      task.delete();
                    },
                    child: TaskWidget(task: task));
              },
            ),
          ),
        ),
      ),
      floatingActionButton: Visibility(
        visible: isFabVisbile,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return AddTaskScreen();
                },
              ),
            );
          },
          child: Image.asset("images/icon_add.png"),
          backgroundColor: Color(0xff18dAA3),
        ),
      ),
    );
  }
}
