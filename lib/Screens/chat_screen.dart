import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/widgets/custom_scaffold_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> with RouteAware {
  bool isReturning = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    _searchController.removeListener(_filterMessages);
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didPopNext() {
    // يتم استدعاء هذه الدالة عند الرجوع إلى الصفحة الرئيسية
    setState(() {
      isReturning = false; // تحديث المتغير وإعادة بناء الواجهة
    });
  }

  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> allMessages = [
    {
      "name": "Olen Sporer",
      "message": "Hi! We are going out tonight, do you want to join us?",
      "time": "5 min"
    },
    {
      "name": "Maria Carry",
      "message": "Darling, please don’t forget to eat your fruits",
      "time": "15 min"
    },
    {
      "name": "Creola",
      "message": "Hi! We are going out tonight, do you want to join us?",
      "time": "25 min"
    },
    {
      "name": "Sofia Sporer",
      "message": "Hi! We are going out tonight, do you want to join us?",
      "time": "1 hour"
    },
    {
      "name": "Jonathan Alls",
      "message": "Darling, please don’t forget to eat your fruits",
      "time": "2 hours"
    },
    {
      "name": "Jessica Arnold",
      "message": "Hi! We are going out tonight, do you want to join us?",
      "time": "3 hours"
    },
  ];

  List<Map<String, String>> filteredMessages = [];
  int? selectedIndex;

  @override
  void initState() {
    super.initState();
    filteredMessages = allMessages;
    _searchController.addListener(_filterMessages);
  }

  void _filterMessages() {
    setState(() {
      String query = _searchController.text.toLowerCase();
      filteredMessages = query.isEmpty
          ? allMessages
          : allMessages
              .where((msg) => msg["name"]!.toLowerCase().contains(query))
              .toList();
    });
  }

  @override
  /*void dispose() {
    _searchController.removeListener(_filterMessages);
    _searchController.dispose();
    super.dispose();
  }*/

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      screenName: "Messages",
      showhomebottombar: true,
      showBackButton: false,
      chatSelected: true,
      homeSelected: isReturning,
      calenderSelected: isReturning,
      notificationSelected: isReturning,
      child: Padding(
        padding: const EdgeInsets.only(
            bottom: 0.0), // Adjust padding to avoid overlapping with navbar
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: TextStyle(color: Color(0xff6F8793)),
                  prefixIcon: Icon(Icons.search, color: Color(0xff6F8793)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  filled: true,
                  fillColor: Color(0xff455A64),
                ),
                style: TextStyle(color: Colors.white),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(
                    bottom: 16.0), // Ensure spacing above the navbar
                itemCount: filteredMessages.length,
                itemBuilder: (context, index) {
                  final message = filteredMessages[index];
                  bool isSelected = selectedIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 5),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Color(0xffFED36A)
                              : Color(0xff455A64),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withAlpha(51),
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(12),
                          leading: CircleAvatar(
                            backgroundImage: AssetImage('assets/person.png'),
                          ),
                          title: Text(message["name"]!,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: isSelected
                                      ? Colors.black
                                      : Colors.white)),
                          subtitle: Text(message["message"]!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color:
                                      isSelected ? Colors.black : Colors.grey)),
                          trailing: Text(message["time"]!,
                              style: TextStyle(
                                  color: isSelected
                                      ? Colors.black
                                      : Colors.white)),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
