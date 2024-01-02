import 'package:flutter/material.dart';
import 'package:flutter_database/utilities/utility.dart';
import 'package:hive/hive.dart';
import 'package:time_pickerr/time_pickerr.dart';

import '../data/task.dart';
import '../widgets/task_type_item_list.dart';

class EditTaskScreen extends StatefulWidget {
  EditTaskScreen({Key? key, required this.task}) : super(key: key);
  Task task;

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final box1 = Hive.box<Task>('taskBox');
  DateTime? _time;
  int _seletedTaskItemList = 0;

  FocusNode negahban1 = FocusNode();
  FocusNode negahban2 = FocusNode();
  TextEditingController? contTaskTitle;
  TextEditingController? contTaskSubTitle;

  @override
  void initState() {
    contTaskTitle = TextEditingController(text: widget.task.title);
    contTaskSubTitle = TextEditingController(text: widget.task.subTitle);
    super.initState();
    negahban1.addListener(() {
      setState(() {});
    });
    negahban2.addListener(() {
      setState(() {});
    });
    var indexx = getTaskTypeList().indexWhere((element) {
      return element.taskTypeEnum == widget.task.taskType.taskTypeEnum;
    });
    _seletedTaskItemList = indexx;
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
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff18DAA3),
                    minimumSize: Size(200, 48),
                  ),
                  onPressed: () {
                    widget.task.title = contTaskTitle!.text;
                    widget.task.subTitle = contTaskSubTitle!.text;
                    widget.task.time = _time!;
                    widget.task.taskType =
                        getTaskTypeList()[_seletedTaskItemList];
                    widget.task.save();
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "ویرایش کردن تسک",
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

