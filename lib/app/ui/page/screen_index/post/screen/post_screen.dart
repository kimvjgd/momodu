import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:uni_meet_dong/app/binding/init_bindings.dart';
import 'package:uni_meet_dong/app/controller/comment_controller.dart';
import 'package:uni_meet_dong/app/controller/post_controller.dart';
import 'package:uni_meet_dong/app/ui/components/app_color.dart';
import 'package:uni_meet_dong/app/ui/page/screen_index/post/screen/post_add_screen.dart';
import 'package:uni_meet_dong/app/ui/page/screen_index/post/widget/post_item.dart';

class PostScreen extends GetView<PostController> {
  const PostScreen({Key? key}) : super(key: key);



  Future _onRefresh() async {
    controller.loadPostList();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: app_color,
        actions: [IconButton(onPressed: () {
          Get.to(PostAddScreen(),);
        }, icon: Icon(Icons.add,color: Colors.black,))],
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: _postList(),
      ),
    );
  }

  Widget _postList() {
    return Obx(() => ListView(
          children: List.generate(
              controller.postList.length,
              (index) => PostItem(post: controller.postList[index])).toList(),
        ));
  }
}
