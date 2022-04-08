import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  String? host;
  String? content;
  DateTime? commentTime;
  // DocumentReference? reference;

  Comment({
    this.host,
    this.content,
    this.commentTime,
    // this.reference,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
        host:json['host'] == null ? '' : json['host'] as String,
        content:json['content'] == null ? '' : json['content'] as String,
        commentTime:json['comment_time'] == null ? DateTime.now() : json['comment_time'].toDate(),
    );
  }

  // Comment.fromSnapshot(DocumentSnapshot snapshot)
  Comment.fromMap(Map<String, dynamic>? map)
    : host = map?['host'],
      content = map?['content'],
      commentTime = map?['comment_time'].toUtc();

  Comment.fromSnapshot(DocumentSnapshot snapshot)
    : this.fromMap(snapshot.data() as Map<String, dynamic>?);

  Map<String, dynamic> toMap() {
    return {
      "host": host,
      "content": content,
      "comment_time": commentTime,
    };
  }

}
