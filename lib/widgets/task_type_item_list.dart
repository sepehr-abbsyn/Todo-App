import 'package:flutter/material.dart';

import '../data/task_type.dart';

class TaskTypeItemList extends StatelessWidget {
  TaskTypeItemList(
      {Key? key,
      required this.taskType,
      required this.index,
      required this.selectedTaskTypeList})
      : super(key: key);

  TaskType taskType;
  int index;
  int selectedTaskTypeList;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:
            (selectedTaskTypeList == index) ? Color(0xff18DAA3) : Colors.white,
        border: Border.all(
            color: (selectedTaskTypeList == index)
                ? Color(0xff18DAA3)
                : Colors.grey,
            width: 2),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      margin: EdgeInsets.all(8),
      width: (MediaQuery.of(context).size.width - 48) / 3,
      child: Column(
        children: [
          Image.asset(taskType.image),
          Text(
            taskType.title,
            style: TextStyle(
              fontSize: 18,
              color:
                  (selectedTaskTypeList == index) ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
