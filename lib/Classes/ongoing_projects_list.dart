import 'package:flutter/material.dart';
import 'package:flutter_application_1/Classes/project_class.dart';
import 'package:flutter_application_1/widgets/ongoing_projects_widget.dart';
import 'package:provider/provider.dart';

class OngoingTasksList extends StatelessWidget {
  const OngoingTasksList({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<ProjectModel>(builder: (context, value, child) {
      if (value.ongoinglist.isNotEmpty) {
        return SliverList(
            delegate:
                SliverChildBuilderDelegate(childCount: value.ongoinglist.length,
                    // ignore: non_constant_identifier_names
                    (context, Index) {
          return OngoingProjectsWidget(
              projectClass: value
                  .ongoinglist[Index]); // ✅ تحويل `ProjectClass` إلى Widget
        }));
      } else {
        return SliverToBoxAdapter(
          child: Container(
            height: 150,
            child: Center(
              child: Text(
                'No Ongoing Projects Yet !',
                style: TextStyle(color: Color(0xffFED36A), fontSize: 25),
              ),
            ),
          ),
        );
      }
    });
  }
}
