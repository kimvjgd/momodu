import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_meet_dong/app/controller/chatroom_controller.dart';
import 'package:uni_meet_dong/app/data/repository/chat_repository.dart';
import 'package:uni_meet_dong/app/ui/components/app_color.dart';
import 'package:uni_meet_dong/app/ui/page/screen_index/chat/screen/chatroom_screen.dart';

class ChatListScreen extends GetView<ChatroomController> {
  const ChatListScreen({Key? key}) : super(key: key);

  Future _onRefresh() async {
    controller.getChatroomList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: app_color,
        centerTitle: true,
        title: Text('채팅'),
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: _chatroomList(),
      ),
    );
  }

  Widget _chatroomList() {
    return Obx(() => ListView(
          children: List.generate(
              controller.chatroomList.length,
              (index) => GestureDetector(
                onTap: (){
                  Get.to(()=>ChatroomScreen(chatroomKey: controller.chatroomList[index].chatId!));
                },
                child: Card(
                      child: Column(
                        children: [
                          Text(controller.chatroomList[index].postTitle!),
                          Text(
                            controller.chatroomList[index].lastMessageTime.toString(),
                            style: TextStyle(fontSize: 30, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
              )).toList(),
        ));
  }
}
