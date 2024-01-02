import 'package:flutter/material.dart';
import 'package:flutter_database/screens/edit_task_screen.dart';
import '../data/task.dart';

class TaskWidget extends StatefulWidget {
  TaskWidget({Key? key, required this.task}) : super(key: key);
  Task task;

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  bool isBoxChecked = false;
  @override
  void initState() {
    super.initState();
    isBoxChecked = widget.task.isDone;
  }

  @override
  Widget build(BuildContext context) {
    return getTaskItem();
  }

  Widget getTaskItem() {
    return GestureDetector(
      onTap: () {
        setState(() {
          isBoxChecked = !isBoxChecked;
          widget.task.isDone = isBoxChecked;
          widget.task.save();
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: Color(
            0xfffffffff,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        height: 132,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: getMainContent(),
        ),
      ),
    );
  }

  Row getMainContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Transform.scale(
                    scale: 1.2,
                    child: Checkbox(
                      value: isBoxChecked,
                      activeColor: Colors.green,
                      checkColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      onChanged: (onChanged) {},
                    ),
                  ),
                  Text(widget.task.title),
                ],
              ),
              Text(
                widget.task.subTitle,
                overflow: TextOverflow.ellipsis,
              ),
              Spacer(),
              getTimeAndEditBadges(),
            ],
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Image.asset(widget.task.taskType.image),
      ],
    );
  }

  Column getTitle() {
    return Column(
      children: [
        Text("ladm;asd"),
        Text("sas;djn;asd"),
        getTimeAndEditBadges(),
      ],
    );
  }

  Row getTimeAndEditBadges() {
    return Row(
      children: [
        Container(
          width: 95,
          height: 35,
          decoration: BoxDecoration(
              color: Color(0xff18dAA3),
              borderRadius: BorderRadius.circular(18)),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 6,
              horizontal: 12,
            ),
            child: Row(
              children: [
                Text(
                  "${widget.task.time.hour}:${getMinUnderTen(widget.task.time)}",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
                SizedBox(width: 10),
                Image.asset("images/icon_time.png"),
              ],
            ),
          ),
        ),
        SizedBox(width: 12),
        InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => EditTaskScreen(task: widget.task),
              ),
            );
          },
          child: Container(
            width: 95,
            height: 35,
            decoration: BoxDecoration(
                color: Color(0xffE2F6F1),
                borderRadius: BorderRadius.circular(18)),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 6,
                horizontal: 12,
              ),
              child: Row(
                children: [
                  Text(
                    " ک ",
                    style: TextStyle(
                      color: Color(0xff18dAA3),
                    ),
                  ),
                  SizedBox(width: 10),
                  Image.asset("images/icon_edit.png"),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  String getMinUnderTen(DateTime time) {
    if (time.minute < 10) {
      return "0${time.minute}";
    } else {
      return time.minute.toString();
    }
  }
}
