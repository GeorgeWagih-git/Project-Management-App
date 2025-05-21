import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/inside_chat_screen.dart';
import 'package:flutter_application_1/core/shared_perfs.dart';
import '../Classes/user_model.dart';
import '../widgets/custom_scaffold_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late TextEditingController _searchController;
  late List<UserModel> _filteredUsers;
  late List<UserModel> allUsers;
  UserModel? currentUser;
  late String authtoken;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchController.addListener(_filterUsers);

    // Initialize lists
    _filteredUsers = [];
    allUsers = [];

    // Load data
    loadUserData();
  }

  void loadUserData() async {
    final loadedUser = await AppPrefs.getUser();
    if (loadedUser != null) {
      setState(() {
        currentUser = loadedUser;
        idController = TextEditingController(text: currentUser!.id);
      });
    }
  }

  late TextEditingController idController;

  void _filterUsers() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredUsers = allUsers
          .where((user) =>
              user.id != currentUser!.id &&
              (user.fullName.toLowerCase().contains(query) ||
                  user.userName.toLowerCase().contains(query)))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      screenName: "Messages",
      chatSelected: true,
      showhomebottombar: true,
      showBackButton: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          children: [
            SizedBox(width: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "Search",
                      hintStyle: const TextStyle(color: Color(0xff6F8793)),
                      prefixIcon:
                          const Icon(Icons.search, color: Color(0xff6F8793)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      filled: true,
                      fillColor: const Color(0xff455A64),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(width: 16),
              ],
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 16.0),
                itemCount: _filteredUsers.length,
                itemBuilder: (context, index) {
                  final user = _filteredUsers[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => InsideChatScreen(
                            token: authtoken,
                            receiverId: user.id,
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 5),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xff455A64),
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
                            backgroundImage: user.imageUrl!.isNotEmpty
                                ? NetworkImage(user.imageUrl!)
                                : const AssetImage('assets/person.png')
                                    as ImageProvider,
                          ),
                          title: Text(user.fullName,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          subtitle: Text(user.userName,
                              style: const TextStyle(color: Colors.grey)),
                          trailing: const Icon(Icons.chat, color: Colors.white),
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
