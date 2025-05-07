import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Cubits/ongoing_porject_cubit/ongoing_porject_cubit.dart';
import 'package:flutter_application_1/Screens/welcome_screen.dart';
import 'package:flutter_application_1/core/api/dio_consumer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();

void main() {
  runApp(
    BlocProvider(
        create: (context) => OngoingProjectCubit(DioConsumer(dio: Dio())),
        child: ProjectManagement()),
  );
}

class ProjectManagement extends StatelessWidget {
  const ProjectManagement({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorObservers: [routeObserver],
      home: WelcomeScreen(),
    );
  }
}
