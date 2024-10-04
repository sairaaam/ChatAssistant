import 'package:flutter/material.dart';
import 'package:flutter_chatgpt_clone/features/chat/presentation/pages/conversation_page.dart';
import 'package:flutter_chatgpt_clone/features/global/const/page_const.dart';

class OnGenerateRoute {
  static Route<dynamic> route(RouteSettings settings) {
    switch (settings.name) {
      case PageConst.conversationPage:
        return MaterialPageRoute(
          builder: (_) =>
              ConversationPage(), // Removed args since it's not used
        );

      default:
        return MaterialPageRoute(
          builder: (_) => ErrorPage(),
        );
    }
  }
}

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Error"),
      ),
      body: Center(
        child: Text("Page not found"),
      ),
    );
  }
}
