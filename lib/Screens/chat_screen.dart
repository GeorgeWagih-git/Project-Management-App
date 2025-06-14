import 'package:flutter/material.dart';
import 'package:flutter_application_1/Classes/home_chat_model.dart';
import 'package:flutter_application_1/Cubits/chat%20cubit/chat_cubit.dart';
import 'package:flutter_application_1/Screens/inside_chat_screen.dart';
import 'package:flutter_application_1/core/shared_perfs.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/widgets/custom_scaffold_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with RouteAware {
  final TextEditingController _searchController = TextEditingController();
  List<HomeChatModel> _chatList = [];
  List<HomeChatModel> _filteredChatList = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterChats);

    // Load chats when screen is first shown
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _loadChats();
    });
  }

  void _loadChats() {
    context.read<ChatCubit>().loadChatHome((chatList) {
      if (!mounted) return;
      setState(() {
        _chatList = chatList;
        _filteredChatList = chatList;
      });
    });
  }

  void _filterChats() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredChatList = _chatList
          .where((chat) => chat.email.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Subscribe to navigation events
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didPopNext() {
    // Called when returning to this screen
    _loadChats();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      screenName: "Messages",
      chatSelected: true,
      showhomebottombar: true,
      showBackButton: false,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xff37474F),
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                controller: _searchController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: Colors.white70),
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
            ),
          ),
          Expanded(
            child: _filteredChatList.isEmpty
                ? const Center(
                    child: Text(
                      'No chats found.',
                      style: TextStyle(color: Colors.white54),
                    ),
                  )
                : ListView.builder(
                    itemCount: _filteredChatList.length,
                    itemBuilder: (context, index) {
                      final chat = _filteredChatList[index];
                      return GestureDetector(
                        onTap: () async {
                          final sender = await AppPrefs.getUser();
                          if (sender == null) return;
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => InsideChatScreen(
                                senderId: sender.id,
                                receiverEmail: chat.email,
                              ),
                            ),
                          ).then((_) {
                            // Reload after returning
                            if (mounted) _loadChats();
                          });
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
                                  color: Colors.black26,
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(12),
                              leading: const CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/person.png'),
                              ),
                              title: Text(
                                chat.email,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              subtitle: Text(
                                chat.latestMessage,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: Colors.white70),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
