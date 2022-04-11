import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uni_meet_dong/app/data/model/firestore_keys.dart';
import 'package:uni_meet_dong/app/data/model/post_model.dart';

class PostRepository {

  // Singleton

  // static final PostRepository _postRepository = PostRepository._internal();
  // factory PostRepository() => _postRepository;
  // PostRepository._internal();

  static Future<void> createPost(
      {required String title, required String content, required String place, required int headCount, required DateTime createdDate, required String host }) async {
    DocumentReference postRef = FirebaseFirestore.instance.collection('posts').doc();
    PostModel postData = PostModel(
        title: title,
        postKey: postRef.id,
        content: content,
        place: place,
        headCount: headCount,
        createdDate: createdDate,
        host: host,
        numComments: 0);
    await postRef
        .set(postData.toMap());
  }

  static Future<List<PostModel>> loadPostList() async {
    var document = FirebaseFirestore.instance
        .collection(COLLECTION_POSTS)
        .orderBy(KEY_POST_CREATEDDATE, descending: true).limit(10);       // 나중에 더 추가
    var data = await document.get();
    return data.docs.map<PostModel>((e) => PostModel.fromJson(e.id, e.data())).toList();
  }
}