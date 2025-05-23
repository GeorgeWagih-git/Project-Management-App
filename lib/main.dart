import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Classes/notifications_service.dart';
import 'package:flutter_application_1/Cubits/Forget_Password_cubit/forget_password_cubit.dart';
import 'package:flutter_application_1/Cubits/Sign_Up_cubit/sign_up_cubit.dart';
import 'package:flutter_application_1/Cubits/Sign_in_cubit/sign_in_cubit.dart';
import 'package:flutter_application_1/Cubits/ongoing_porject_cubit/ongoing_porject_cubit.dart';
import 'package:flutter_application_1/Screens/welcome_screen.dart';
import 'package:flutter_application_1/core/api/dio_consumer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timezone/data/latest.dart' as tz;

final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  tz.initializeTimeZones();

  final notificationService = NotificationsService();
  await notificationService.initNotifications();
  await notificationService.requestNotificationPermission();

  final isEnabled = await notificationService.areNotificationsEnabled();
  if (isEnabled) {
    await notificationService.enableNotifications(
      title: "Daily Reminder",
      body: "Don't forget to check the app!",
      hour: 21,
      min: 5,
    );
  }
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => OngoingProjectCubit(DioConsumer(dio: Dio())),
        ),
        BlocProvider(
          create: (context) => SignInCubit(DioConsumer(dio: Dio())),
        ),
        BlocProvider(
          create: (context) => SignUpCubit(DioConsumer(dio: Dio())),
        ),
        BlocProvider(
          create: (context) => ForgetPasswordCubit(DioConsumer(dio: Dio())),
        ),
      ],
      child: const ProjectManagement(),
    ),
  );
}

class ProjectManagement extends StatelessWidget {
  const ProjectManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorObservers: [routeObserver],
      home: WelcomeScreen(),
    );
  }
}
