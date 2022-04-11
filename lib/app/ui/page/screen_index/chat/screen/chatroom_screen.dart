import 'package:flutter/material.dart';
import 'package:uni_meet_dong/app/controller/auth_controller.dart';
import 'package:uni_meet_dong/app/data/model/chat_model.dart';
import 'package:uni_meet_dong/app/data/repository/chat_repository.dart';
import 'package:uni_meet_dong/app/ui/page/screen_index/chat/widget/chatText.dart';

class ChatroomScreen extends StatefulWidget {
  String chatroomKey;
  ChatroomScreen({required this.chatroomKey, Key? key}) : super(key: key);

  @override
  State<ChatroomScreen> createState() => _ChatroomScreenState();
}

class _ChatroomScreenState extends State<ChatroomScreen> {
  TextEditingController _chatController = TextEditingController();

  @override
  void dispose() {
    _chatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      Size _size = MediaQuery.of(context).size;
      return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: Column(
            children: [
              MaterialBanner(
                  padding: EdgeInsets.zero,
                  content: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.wysiwyg),
                        title: RichText(
                          text: TextSpan(
                              text: '신촌에서 3:3 술마실분?   ',
                              style: TextStyle(color: Colors.black),
                              children: [
                                TextSpan(
                                  text: '2022/04/11',
                                )
                              ]),
                        ),
                      )
                    ],
                  ),
                  actions: [Container()]),
              Expanded(
                  child: Container(
                color: Colors.white,
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return ChatText(size: _size, isMine: index%3==1?true:false);
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 3,
                      );
                    },
                    itemCount: 30),
              )),
              _buildInputBar()
            ],
          ),
        ),
      );
    });
  }

  Row _buildInputBar() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: TextFormField(
              controller: _chatController,
              decoration: InputDecoration(
                  hintText: '메세지를 입력하세요.',
                  isDense: true,
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.grey))),
            ),
          ),
        ),
        IconButton(
            onPressed: () async {
              ChatModel chat = ChatModel(writer: AuthController.to.user.value.uid, message: _chatController.text, createdDate: DateTime.now());
              await ChatRepository().createNewChat(widget.chatroomKey, chat);

              _chatController.clear();
            },
            icon: Icon(
              Icons.send,
              color: Colors.grey,
            )),
      ],
    );
  }
}
