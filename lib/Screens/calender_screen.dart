import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/widgets/custom_scaffold_widget.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({super.key});

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> with RouteAware {
  bool isReturning = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    // يتم استدعاء هذه الدالة عند الرجوع إلى الصفحة الرئيسية
    setState(() {
      isReturning = false; // تحديث المتغير وإعادة بناء الواجهة
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        showhomebottombar: true,
        calenderSelected: true,
        homeSelected: isReturning,
        chatSelected: isReturning,
        notificationSelected: isReturning,
        showappbar: true,
        showBackButton: false,
        screenName: 'Schedule',
        child: Center(
          child: Text(
            'Calender Screen in Processing',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ));
  }
}
