import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:uni_meet_dong/app/binding/init_bindings.dart';
import 'package:uni_meet_dong/app/controller/auth_controller.dart';
import 'package:uni_meet_dong/app/controller/comment_controller.dart';
import 'package:uni_meet_dong/app/data/model/chat_model.dart';
import 'package:uni_meet_dong/app/data/model/chatroom_model.dart';
import 'package:uni_meet_dong/app/data/model/comment_model.dart';
import 'package:uni_meet_dong/app/data/model/post_model.dart';
import 'package:uni_meet_dong/app/data/repository/chat_repository.dart';
import 'package:uni_meet_dong/app/data/repository/comment_repository.dart';

class PostDetailScreen extends GetView<CommentController> {
  final PostModel post;

  PostDetailScreen({required this.post, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<List<CommentModel>>(
          future: commentRepository.loadCommentList(post.postKey),
          initialData: [
            CommentModel(
                host: 'nothing',
                content: 'nothing',
                commentTime: DateTime.now())
          ],
          builder: (context, snapshot) {
            return ListView.builder(
              itemBuilder: (context, index) {
                if (index == 0) {
                  return _intro();
                } else if (index == 1) {
                  return _content();
                } else {
                  return _comment(snapshot);
                }
              },
              itemCount: 3,
            );
          }),
      bottomNavigationBar: post.host != AuthController.to.user.value.uid
          ? SizedBox(
              height: 100,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller.commentTextController,
                    ),
                  ),
                  TextButton(
                      onPressed: () async {
                        CommentModel comment = CommentModel(
                          host: AuthController.to.user.value.uid,
                          content: controller.commentTextController.text,
                          commentTime: DateTime.now(),
                        );
                        await commentRepository.createNewComment(
                            post.postKey, comment.toMap());
                        // 화면 새로고침
                        controller.commentTextController.text = '';
                      },
                      child: Text('코멘트 남기기')),
                ],
              ),
            )
          : SizedBox(),
    );
  }

  Column _comment(AsyncSnapshot<List<CommentModel>> snapshot) {
    return Column(
      children: List.generate(
          snapshot.data!.length,
          (index) => SizedBox(
              width: double.infinity,
              height: 50,
              child: GestureDetector(
                  onTap: () {
                    showDialog(
                        context: Get.context!,
                        //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            //Dialog Main Title
                            title: Column(
                              children: <Widget>[
                                const Text("채팅하기"),
                              ],
                            ),
                            //
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "@@@님과 채팅하기",
                                ),
                              ],
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text("채팅하기"),
                                onPressed: () async {
                                  if(AuthController.to.user.value.uid == post.host && snapshot.data![index].host != null && snapshot.data![index].host != '') {
                                    await ChatRepository().createNewChatroom(ChatroomModel(
                                        allUser: [
                                          post.host!,
                                          snapshot.data![index].host!
                                        ],
                                        createDate: DateTime.now(),
                                        postKey: post.postKey,
                                        headCount: post.headCount, postTitle: post.title, lastMessage: '',
                                        chatId: '', lastMessageTime: DateTime.now()),
                                        AuthController.to.user.value.uid!, snapshot.data![index].host!,     // 탈퇴했을때... 경우를 고려해줘야함
                                    );
                                  }else{
                                    Get.snackbar("알림", "회원이 탈퇴했습니다.");
                                  }

                                  Get.back();
                                },
                              ),
                              TextButton(
                                child: const Text("취소"),
                                onPressed: () {
                                  Get.back();

                                },
                              )
                            ],
                          );
                        });
                  },
                  child: Card(child: Text(snapshot.data![index].content!))))),
    );
  }

  Container _content() {
    return Container(
      child: Column(
        children: [
          Text(
            '내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용'
            '내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용'
            '내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내',
            style: TextStyle(fontSize: 30),
          ),
        ],
      ),
      color: Colors.blue,
    );
  }

  Container _intro() {
    return Container(
      child: Column(
        children: [
          Text(
            'Intro',
            style: TextStyle(fontSize: 30),
          ),
          Text(
            'Intro',
            style: TextStyle(fontSize: 30),
          ),
        ],
      ),
      color: Colors.red,
    );
  }
}
