import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uni_meet_dong/app/data/model/firestore_keys.dart';
import 'package:uni_meet_dong/app/data/model/post.dart';

class PostRepository {

  // Singleton

  // static final PostRepository _postRepository = PostRepository._internal();
  // factory PostRepository() => _postRepository;
  // PostRepository._internal();

  static Future<void> createPost(
      {required String title, required String content, required String place, required int headCount, required DateTime createdDate, required List commentList, required String host }) async {
    DocumentReference postRef = await FirebaseFirestore.instance.collection('posts').doc();
    Post postData = Post(
        title: title,
        postKey: postRef.id,
        content: content,
        place: place,
        headCount: headCount,
        createdDate: createdDate,
        commentList: commentList,
        host: host,
        numComments: 0);
    await postRef
        .set(postData.toMap());
  }

  static Future<List<Post>> loadPostList() async {
    var document = FirebaseFirestore.instance
        .collection('posts')
        .orderBy(KEY_POST_CREATEDDATE, descending: true).limit(10);
    var data = await document.get();
    return data.docs.map<Post>((e) => Post.fromJson(e.id, e.data())).toList();
  }
}