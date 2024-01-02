import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:time_pickerr/time_pickerr.dart';

import '../data/task.dart';
import '../widgets/task_type_item_list.dart';
import '../utilities/utility.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final box1 = Hive.box<Task>('taskBox');

  FocusNode negahban1 = FocusNode();
  FocusNode negahban2 = FocusNode();
  final TextEditingController contTaskTitle = TextEditingController();
  final TextEditingController contTaskSubTitle = TextEditingController();
  DateTime? _time;
  int _seletedTaskItemList = 0;
  @override
  void initState() {
    super.initState();
    negahban1.addListener(() {
      setState(() {});
    });
    negahban2.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 5,
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 44,
                    ),
                    child: TextField(
                      style: TextStyle(
                          color: Colors.black, fontFamily: "GM", fontSize: 16),
                      focusNode: negahban1,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        labelText: "عنوان تسک",
                        labelStyle: TextStyle(
                          fontSize: 20,
                          color: negahban1.hasFocus
                              ? Color(0xff18DAA3)
                              : Color(0xffC5C5C5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide:
                              BorderSide(color: Color(0xffC5C5C5), width: 3.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(
                            width: 3,
                            color: Color(0xff18DAA3),
                          ),
                        ),
                      ),
                      controller: contTaskTitle,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 44),
                    child: TextField(
                      controller: contTaskSubTitle,
                      maxLines: 2,
                      style: TextStyle(
                          color: Colors.black, fontFamily: "GM", fontSize: 16),
                      focusNode: negahban2,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        labelText: "توضیحات تسک",
                        labelStyle: TextStyle(
                          fontSize: 20,
                          color: negahban2.hasFocus
                              ? Color(0xff18DAA3)
                              : Color(0xffC5C5C5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide:
                              BorderSide(color: Color(0xffC5C5C5), width: 3.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(
                            width: 3,
                            color: Color(0xff18DAA3),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: CustomHourPicker(
                    elevation: 6,
                    title: 'زمان تسک رو انتخاب کن',
                    titleStyle: TextStyle(
                      color: Color(0xff18DAA3),
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    negativeButtonText: 'حذف کن',
                    negativeButtonStyle: TextStyle(
                      color: Color.fromARGB(255, 218, 66, 24),
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    positiveButtonText: 'انتخاب زمان',
                    positiveButtonStyle: TextStyle(
                      color: Color(0xff18DAA3),
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    onPositivePressed: (context, time) {
                      _time = time;
                    },
                    onNegativePressed: (context) {},
                  ),
                ),
                Container(
                  height: 170,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: getTaskTypeList().length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            _seletedTaskItemList = index;
                          });
                        },
                        child: TaskTypeItemList(
                          taskType: getTaskTypeList()[index],
                          index: index,
                          selectedTaskTypeList: _seletedTaskItemList,
                        ),
                      );
                    },
                  ),
                ),
                // Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff18DAA3),
                    minimumSize: Size(200, 48),
                  ),
                  onPressed: () {
                    String taskTitle = contTaskTitle.text;
                    String taskSubTitle = contTaskSubTitle.text;
                    var task = Task(
                        title: taskTitle,
                        subTitle: taskSubTitle,
                        time: _time!,
                        taskType: getTaskTypeList()[_seletedTaskItemList]);
                    box1.add(task);
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "اضافه کردن تسک",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
