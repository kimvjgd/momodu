import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_meet_dong/app/data/model/post.dart';
import 'package:uni_meet_dong/app/data/utils/timeago_util.dart';
import 'package:uni_meet_dong/app/ui/page/screen_index/post/screen/post_detail_screen.dart';


class PostItem extends StatelessWidget {
  final Post post;
  const PostItem({
    required this.post,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TimeAgo? _timeAgo;
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height/10,
      child: GestureDetector(
        onTap: (){
          Get.to(()=>PostDetailScreen(post: post,));
        },
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 나중에 글씨제한 둘 예정, 일단 기능 구현 먼저
                  Text(post.title??'빈 제목',style: TextStyle(fontSize: 26),textAlign: TextAlign.start,),
                  Text(TimeAgo.timeAgoSinceData(post.createdDate!))
                ],
              ),
              Text(post.content??'내용 없음',style: TextStyle(fontSize: 16,color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }
}