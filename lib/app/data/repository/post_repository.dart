import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uni_meet_dong/app/data/model/firestore_keys.dart';
import 'package:uni_meet_dong/app/data/model/post.dart';

class PostRepository {

  // Singleton

  // static final PostRepository _postRepository = PostRepository._internal();
  // factory PostRepository() => _postRepository;
  // PostRepository._internal();

  static Future<void> updatePost(Post postData) async {
    await FirebaseFirestore.instance.collection('posts').add(postData.toMap());
  }

  static Future<List<Post>> loadPostList() async {
    var document = FirebaseFirestore.instance
        .collection('posts')
        .orderBy(KEY_POST_CREATEDDATE, descending: true).limit(10);
    var data = await document.get();
    return data.docs.map<Post>((e)=>Post.fromJson(e.id, e.data())).toList();

  }



}