import 'package:flutter/material.dart';
import 'package:flutter_application_1/Classes/project_class.dart';
import 'package:flutter_application_1/Classes/task_model.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class TaskContainerWidget extends StatefulWidget {
  TaskContainerWidget(
      {super.key,
      required this.taskitem,
      required this.project,
      this.showcheckbox = false,
      this.showremoveicon = false,
      this.showrenameicon = false});
  final TaskItem taskitem;
  final ProjectClass project;

  bool showcheckbox;
  bool showremoveicon;
  bool showrenameicon;
  @override
  State<TaskContainerWidget> createState() => _TaskContainerWidgetState();
}

class _TaskContainerWidgetState extends State<TaskContainerWidget> {
  final TextEditingController _taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        width: double.infinity,
        height: 58,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          color: Color(0xff455A64),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Center(
                child: Text(
                  widget.taskitem.name,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            if (widget.showcheckbox)
              Consumer<TaskModel>(
                builder: (context, model, child) {
                  return Checkbox(
                    activeColor: Color(0xffFED36A),
                    checkColor: Colors.black,
                    value: widget.taskitem.isdone,
                    onChanged: (bool? value) {
                      setState(() {
                        widget.taskitem.isdone = value ?? false;
                      });

                      // 🔥 تحديث حالة المشروع بعد تعديل المهمة
                      Provider.of<ProjectModel>(context, listen: false)
                          .toggleProjectStatus(widget.project);
                    },
                  );
                },
              ),
            if (widget.showremoveicon)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Consumer<TaskModel>(
                    builder: (context, model, child) {
                      return MaterialButton(
                          minWidth: 30,
                          onPressed: () {
                            model.deleteTask(widget.taskitem);
                          },
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ));
                    },
                  ),
                  if (widget.showrenameicon)
                    Consumer<TaskModel>(
                      builder: (context, model, child) {
                        return MaterialButton(
                            minWidth: 30,
                            onPressed: () {
                              showModalBottomSheet(
                                backgroundColor: Color(0xff212832),
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    padding: EdgeInsets.all(16.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        ListTile(
                                          title: Text(
                                            "Rename Task",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          onTap: () {
                                            Navigator.pop(
                                                context); // إغلاق القائمة
                                          },
                                        ),
                                        TextField(
                                          controller: _taskController,
                                          style: TextStyle(color: Colors.white),
                                          decoration: InputDecoration(
                                            labelStyle:
                                                TextStyle(color: Colors.white),
                                            labelText: "Task Name ",
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25)),
                                          ),
                                          autofocus: true,
                                        ),
                                        SizedBox(
                                            height:
                                                16), // مسافة بين الحقل والزر
                                        Consumer<TaskModel>(
                                            builder: (context, model, child) {
                                          return MaterialButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20.0)),
                                            color: Color(0xffFED36A),
                                            onPressed: () {
                                              // إضافة المهمة هنا
                                              if (_taskController
                                                  .text.isNotEmpty) {
                                                model.renameTask(
                                                    widget.taskitem,
                                                    _taskController.text);
                                                _taskController.clear();
                                                Navigator.pop(
                                                    context); // 🟢 مسح الحقل بعد الإضافة
                                              }

                                              // إغلاق الواجهة
                                            },
                                            child: Text('Rename'),
                                          );
                                        }),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: Icon(
                              Icons.drive_file_rename_outline,
                              color: Colors.white,
                            ));
                      },
                    ),
                ],
              )
          ],
        ),
      ),
    );
  }
}
