class ChatRoom {
  List<String>? allUser;
  DateTime? createDate;
  DateTime? confirmDate;
  String? chatId;
  String? postKey;
  int? headCount;
  // String? reference;

  ChatRoom({required this.allUser, required this.createDate,
  required this.chatId, required this.confirmDate, required this.postKey,required this.headCount});

  factory ChatRoom.fromJson(Map<String, dynamic> json) {
    return ChatRoom(
        allUser : json['allUser'] == null ? [] : json['allUser'] as List<String>,
        createDate : json['createDate'] == null ? DateTime.now() : json['createDate'] as DateTime,
        confirmDate : json['confirmDate'] == null ? DateTime.now() : json['confirmDate'] as DateTime,
        chatId: json['chatId']== null ? '' : json['chatId'] as String,
        postKey : json['postKey'] == null ? '' : json['postKey'] as String,
        headCount : json['headCount'] == null ? 2 : json['headCount'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "allUser": allUser,
      "createDate": createDate,
      "confirmDate": confirmDate,
      "chatId": chatId,
      "postKey": postKey,
      "headCount": headCount,
    };
  }
}