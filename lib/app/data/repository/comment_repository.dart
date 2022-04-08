import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:uni_meet_dong/app/data/model/comment.dart';
import 'package:uni_meet_dong/app/data/model/firestore_keys.dart';

class CommentRepository {
  Logger logger = Logger();
  Future<void> createNewComment(String postKey, Map<String, dynamic> commentData) async {
    final DocumentReference postRef = FirebaseFirestore.instance.collection(COLLECTION_POSTS).doc(postKey);
    final DocumentReference commentRef =
        postRef.collection(COLLECTION_COMMENTS).doc();

    return FirebaseFirestore.instance.runTransaction((tx) async {
        tx.set(commentRef, commentData);
        // int numOfComments = postSnapshot.get(KEY_POST_NUMCOMMENTS);
    });
  }

  Future<List<Comment>> loadCommentList(String postKey) async {
    var document = FirebaseFirestore.instance
        .collection(COLLECTION_POSTS)
        .doc(postKey)
        .collection(COLLECTION_COMMENTS)
        .orderBy('comment_time', descending: true);
    var data = await document.get();
    // print('@@docs[0]@@${data.docs[0]}');
    // print('@@docs[0].data()@@${data.docs[0].data()}');
    // print('@@docs[0].data()["host"]@@${data.docs[0].data()['host']}');
    print('@@data.size@@${data.size}');
    List<Comment> comments = [];
    for (int i=0; i<data.size; i++){
      // print('@@docs[0].data()@@${data.docs[i].data()}');

      // Comment comment = Comment.fromJson(data.docs[i].data());
      // print('@@docs[$i].data()["host"]@@${data.docs[i].data()['host']}');
      // print('@@docs[$i].data()["host"]@@${data.docs[i].data()['content']}');
      // print('@@docs[$i].data()["host"]@@${data.docs[i].data()['comment_time']}');

      Comment comment = Comment(
        host: data.docs[i].data()['host'],
        content: data.docs[i].data()['content'],
        commentTime: data.docs[i].data()['comment_time'].toDate(),
      );
      print(comment);
      comments.add(comment);
    }
    return comments;
  }

}
CommentRepository commentRepository = CommentRepository();