import 'package:flutter/material.dart';
import 'package:uni_meet_dong/app/data/model/comment.dart';
import 'package:uni_meet_dong/app/data/model/post.dart';
import 'package:uni_meet_dong/app/data/repository/comment_repository.dart';

class PostDetailScreen extends StatelessWidget {
  final Post post;

  const PostDetailScreen({required this.post, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<List<Comment>>(
        future: commentRepository.loadCommentList(post.postKey),
          initialData: [
            Comment(
                host: 'aa',
                content: 'afjndsa',
                commentTime: DateTime.now())
          ],
        builder: (context, snapshot) {
          return ListView.builder(
            itemBuilder: (context, index) {
              if (index == 0) {
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
              } else if (index == 1) {
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
              } else {
                return Column(
                  children: List.generate(snapshot.data!.length, (index) => Text(snapshot.data![index].content!)),
                );
              }
            },
            itemCount: 3,
          );
        }
      ),
      bottomNavigationBar: TextButton(
          onPressed: () async {
            await commentRepository.createNewComment(
                post.postKey, {'host': '1111', 'content': '1111111temptemp', 'comment_time': DateTime.now()});
          },
          child: Text('코멘트 남기기')),
    );
  }
}
