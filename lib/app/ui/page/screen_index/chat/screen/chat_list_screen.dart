import 'package:flutter/material.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return Container(
          height: 100,
          color: Colors.greenAccent,
        );
      },
      itemCount: 4,
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: 10,
        );
      },
    );
  }
}
