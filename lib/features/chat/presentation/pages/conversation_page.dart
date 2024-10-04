import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chatgpt_clone/features/chat/domain/entities/chat_message_entity.dart';
import 'package:flutter_chatgpt_clone/features/chat/presentation/cubit/chat_conversation/chat_conversation_cubit.dart';
import 'package:flutter_chatgpt_clone/features/chat/presentation/widgets/chat_message_single_item.dart';
import 'package:flutter_chatgpt_clone/features/chat/presentation/widgets/example_widget.dart';
import 'package:flutter_chatgpt_clone/features/chat/presentation/widgets/left_nav_button_widget.dart';
import 'package:flutter_chatgpt_clone/features/global/common/common.dart';
import 'package:flutter_chatgpt_clone/features/global/const/app_const.dart';
import 'package:flutter_chatgpt_clone/features/global/custom_text_field/custom_text_field.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isRequestProcessing;
  final VoidCallback? onTap;
  final ValueChanged<String>? onSubmit;

  const CustomTextField({
    Key? key,
    required this.textEditingController,
    required this.isRequestProcessing,
    this.onTap,
    this.onSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      onTap: onTap,
      onSubmitted: onSubmit,
      style: TextStyle(
        color: Colors.white, // Text color inside the TextField
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[300], // Light grey background
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide.none, // No border for a clean look
        ),
        hintText: 'Type your message here...',
        hintStyle:
            TextStyle(color: Colors.white70), // Optional: Hint text color
      ),
    );
  }
}

class ConversationPage extends StatefulWidget {
  const ConversationPage({Key? key}) : super(key: key);

  @override
  State<ConversationPage> createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  TextEditingController _messageController = TextEditingController();
  bool _isRequestProcessing = false;
  ScrollController _scrollController = ScrollController();
  bool _isSidebarVisible = false;

  @override
  void initState() {
    _messageController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // Ensure there's content to scroll before calling the scroll function
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients &&
          _scrollController.position.maxScrollExtent > 0) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 500),
          curve: Curves.decelerate,
        );
      }
    });

    return Scaffold(
      body: Stack(
        children: [
          Row(
            children: [
              // Sidebar (hidden initially based on _isSidebarVisible, not screen size)
              if (_isSidebarVisible) _buildSidebar(screenWidth),

              // Chat Area
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(249, 255, 255, 255),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: BlocBuilder<ChatConversationCubit,
                            ChatConversationState>(
                          builder: (context, chatConversationState) {
                            if (chatConversationState
                                is ChatConversationLoaded) {
                              final chatMessages =
                                  chatConversationState.chatMessages;

                              if (chatMessages.isEmpty) {
                                return ExampleWidget(
                                  onMessageController: (message) {
                                    setState(() {
                                      _messageController.value =
                                          TextEditingValue(text: message);
                                    });
                                  },
                                );
                              } else {
                                return ListView.builder(
                                  itemCount: _calculateListItemLength(
                                      chatMessages.length),
                                  controller: _scrollController,
                                  itemBuilder: (context, index) {
                                    if (index >= chatMessages.length) {
                                      return _responsePreparingWidget();
                                    } else {
                                      return ChatMessageSingleItem(
                                        chatMessage: chatMessages[index],
                                      );
                                    }
                                  },
                                );
                              }
                            }
                            return ExampleWidget(
                              onMessageController: (message) {
                                setState(() {
                                  _messageController.value =
                                      TextEditingValue(text: message);
                                });
                              },
                            );
                          },
                        ),
                      ),

                      // Adjusting width of the CustomTextField based on screen size
                      Container(
                        width: MediaQuery.of(context).size.width < 600
                            ? MediaQuery.of(context).size.width *
                                0.9 // 100% width for small screens
                            : 1000, // Fixed width for larger screens
                        child: CustomTextField(
                          isRequestProcessing: _isRequestProcessing,
                          textEditingController: _messageController,
                          onTap: () async {
                            _promptTrigger();
                          },
                          onSubmit: (value) {
                            _messageController.text = value;
                            _promptTrigger();
                          },
                        ),
                      ),

                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Toggle button for sidebar (visible for all screen sizes)
          Positioned(
            top: 10,
            left: 10,
            child: IconButton(
              icon: Icon(
                _isSidebarVisible ? Icons.close : Icons.menu,
                color: const Color.fromARGB(255, 189, 187, 187),
              ),
              onPressed: () {
                setState(() {
                  _isSidebarVisible = !_isSidebarVisible;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar(double screenWidth) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: screenWidth < 600
          ? screenWidth * 0.5
          : 300, // Sidebar width adjusts based on screen size
      decoration: BoxDecoration(
        boxShadow: glowBoxShadow,
        color: Colors.white, // Background color of the sidebar
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row containing only the new chat icon at the right
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 10), // Padding on the left for alignment
              IconButton(
                icon: Icon(Icons.add, color: Colors.black),
                onPressed: () {
                  // Trigger action for starting a new chat
                  // Handle the "New Chat" functionality here
                },
              ),
            ],
          ),
          SizedBox(height: 20),
          Expanded(
            child: Scrollbar(
              thumbVisibility:
                  true, // Ensure scrollbar is visible when scrolling
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Add your list of old conversations here
                    Text(
                      "Previous Conversations", // Example header
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ListView.builder(
                      physics:
                          NeverScrollableScrollPhysics(), // Prevent internal scrolling
                      shrinkWrap:
                          true, // Allows ListView to fit inside ScrollView
                      itemCount:
                          10, // Example: number of previous conversations
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text("Conversation ${index + 1}"),
                          onTap: () {
                            // Handle tapping on an old conversation
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  int _calculateListItemLength(int length) {
    return _isRequestProcessing ? length + 1 : length;
  }

  Widget _responsePreparingWidget() {
    return Container(
      height: 60,
      alignment: Alignment.center,
      child: Image.asset("assets/loading_response.gif"),
    );
  }

  void _promptTrigger() {
    if (_messageController.text.isEmpty) return;

    final humanChatMessage = ChatMessageEntity(
      messageId: ChatGptConst.Human,
      queryPrompt: _messageController.text,
    );

    BlocProvider.of<ChatConversationCubit>(context)
        .chatConversation(
      chatMessage: humanChatMessage,
      onCompleteReqProcessing: (isRequestProcessing) {
        setState(() {
          _isRequestProcessing = isRequestProcessing;
        });
      },
    )
        .then((_) {
      setState(() {
        _messageController.clear();
      });
      if (_scrollController.hasClients) {
        Timer(
          Duration(milliseconds: 100),
          () => _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 500),
            curve: Curves.decelerate,
          ),
        );
      }
    });
  }
}
