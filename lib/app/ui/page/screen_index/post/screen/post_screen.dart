import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:uni_meet_dong/app/controller/post_controller.dart';
import 'package:uni_meet_dong/app/ui/page/screen_index/post/widget/post_item.dart';

class PostScreen extends GetView<PostController> {
  const PostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var logger = Logger();
    return ListView(
      children: [
        _postList(),

        Container(color: Colors.red,width: 200,height: 200,child: Text(controller.postList.length.toString()),)
      ],
    );
  }
  Widget _postList() {
    return Obx(()=>Column(
      children: List.generate(controller.postList.length, (index) => Column(
        children: [
          PostItem(post: controller.postList[index]),
          Container(color: Colors.blue,width: 30,height: 30,)
        ],
      )).toList(),
    ));
  }

}



