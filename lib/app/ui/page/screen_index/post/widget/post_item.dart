import 'package:flutter/material.dart';
import 'package:uni_meet_dong/app/data/model/post.dart';

class PostItem extends StatelessWidget {
  final Post post;
  const PostItem({
    required this.post,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(post.title??'빈 제목',style: TextStyle(fontSize: 30),),
        Text(post.content??'내용 없음',style: TextStyle(fontSize: 20)),
      ],
    );
  }
}