import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/widgets/custom_scaffold_widget.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  NotificationsScreenState createState() => NotificationsScreenState();
}

class NotificationsScreenState extends State<NotificationsScreen>
    with RouteAware {
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

  List<Map<String, String>> notifications = [
    {
      'id': '1',
      'title': 'Tina Tona',
      'subtitle':
          'HR Consultant, & Life Coach, commented on an Opportunity you commented on: "Hello I am..."',
      'time': '15 hours ago'
    },
    {
      'id': '2',
      'title': 'Hey Abayomi',
      'subtitle': "We've got a new beta testing opportunity for you.",
      'time': '17 hours ago'
    },
    {
      'id': '3',
      'title': 'Agba Baller',
      'subtitle':
          'Commented on an opportunity you commented on: "Hello, may this message find you.."',
      'time': '1 day ago'
    },
    {
      'id': '4',
      'title': 'Hey Abayomi',
      'subtitle':
          "We've got a new mentoring opportunity for you. Tim is looking for people like you.",
      'time': '6 days ago'
    },
    {
      'id': '5',
      'title': 'View featured Product Managers',
      'subtitle': 'Open to Brainstorming.',
      'time': '7 days ago'
    },
  ];

  void clearNotifications() {
    setState(() {
      notifications.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));

    return CustomScaffoldWidget(
      screenName: "Notifications",
      showBackButton: false,
      showhomebottombar: true,
      notificationSelected: true,
      homeSelected: isReturning,
      chatSelected: isReturning,
      calenderSelected: isReturning,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffFED36A),
                  foregroundColor: Colors.black,
                ),
                onPressed: clearNotifications,
                child: const Text("Clear All"),
              ),
            ),
          ),
          Expanded(
            child: CustomScrollView(
              slivers: [
                notifications.isEmpty
                    ? const SliverFillRemaining(
                        child: Center(
                            child: Text('No notifications',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white))),
                      )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final notification = notifications[index];
                            return Dismissible(
                              key: ValueKey(notification['id']),
                              direction: DismissDirection.endToStart,
                              onDismissed: (direction) {
                                setState(() {
                                  notifications.removeWhere((item) =>
                                      item['id'] == notification['id']);
                                });
                              },
                              background: Container(
                                width: double.infinity,
                                color: Colors.red,
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.only(right: 20),
                                child: const Icon(Icons.delete,
                                    color: Colors.white),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 8.0),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: const Color(0xff455A64),
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        notification['title']!,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        notification['subtitle']!,
                                        style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        notification['time']!,
                                        style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          childCount: notifications.length,
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
