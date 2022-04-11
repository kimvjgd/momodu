import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:uni_meet_dong/app/controller/auth_controller.dart';
import 'package:uni_meet_dong/app/data/model/chat_model.dart';
import 'package:uni_meet_dong/app/data/model/chatroom_model.dart';
import 'package:uni_meet_dong/app/data/model/firestore_keys.dart';

class ChatRepository {
  static final ChatRepository _chatRepository = ChatRepository._internal();

  factory ChatRepository() => _chatRepository;

  ChatRepository._internal();

  Future createNewChatroom(
      ChatroomModel chatroom, String postUserId, String commentUserId) async {
    DocumentReference<Map<String, dynamic>> chatroomReference =
        FirebaseFirestore.instance.collection(COLLECTION_CHATROOMS).doc();
    DocumentReference<Map<String, dynamic>> chatReference = FirebaseFirestore
        .instance
        .collection(COLLECTION_CHATROOMS)
        .doc()
        .collection(COLLECTION_CHATS)
        .doc();
    DocumentReference<Map<String, dynamic>> postUserReference =
        FirebaseFirestore.instance.collection(COLLECTION_USERS).doc(postUserId);
    DocumentReference<Map<String, dynamic>> commentUserReference =
        FirebaseFirestore.instance
            .collection(COLLECTION_USERS)
            .doc(commentUserId);

    var chatData = await chatroomReference
        .collection(COLLECTION_CHATS)
        .doc()
        .set(ChatModel(
                writer: '관리자',
                createdDate: DateTime.now(),
                message: '첫 메세지를 보내주세요.')
            .toMap());
    var postUserData = await postUserReference.get();
    var commentUserData = await commentUserReference.get();

    List<dynamic> postUserChatroomList =
        postUserData.data()!['chatroomList'] ?? [];
    List<dynamic> commentUserChatroomList =
        commentUserData.data()!['chatroomList'] ?? [];

    if (postUserChatroomList.contains(chatroomReference.id) ||
        commentUserChatroomList.contains(chatroomReference.id)) {
      Get.snackbar("알림", "이미 채팅방이 존재합니다.");
      return;
    }
    Logger().d(postUserChatroomList.contains(chatroomReference.id) ||
        commentUserChatroomList.contains(chatroomReference.id));
    Logger().d(chatroomReference.id);
    // if (!postUserChatroomList.contains(chatroomReference.id)) {
    // }
    // if (!commentUserChatroomList.contains(chatroomReference.id)) {
    // }
    postUserChatroomList.add(chatroomReference.id);
    commentUserChatroomList.add(chatroomReference.id);

    final DocumentSnapshot documentSnapshot = await chatroomReference.get();
    if (!documentSnapshot.exists) {
      chatroom.chatId = chatroomReference.id;
      chatroom.reference = chatroomReference;
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        transaction.set(chatroomReference, chatroom.toMap());
        transaction.update(
            postUserReference, {KEY_USER_CHATROOMLIST: postUserChatroomList});
        transaction.update(commentUserReference,
            {KEY_USER_CHATROOMLIST: commentUserChatroomList});
      });
    } else {
      Get.snackbar("개발자에게 알림", "chatrooms 생성");
    }
  }

  static Future<List<ChatroomModel>> loadChatroomList(String userKey) async {
    var documentReference =
        FirebaseFirestore.instance.collection(COLLECTION_CHATROOMS);
    var document = documentReference
        .where(KEY_CHATROOM_ALLUSER, arrayContains: userKey)
        .orderBy(KEY_CHATROOM_CREATEDDATE, descending: true);
    var data = await document.get();
    return data.docs
        .map<ChatroomModel>((e) => ChatroomModel.fromJson(e.data()))
        .toList();
  }

  Future createNewChat(String chatroomKey, ChatModel chat) async {
    DocumentReference<Map<String, dynamic>> chatsReference = FirebaseFirestore
        .instance
        .collection(COLLECTION_CHATROOMS)
        .doc(chatroomKey)
        .collection(COLLECTION_CHATS)
        .doc();

    DocumentReference<Map<String, dynamic>> chatroomReference =
        FirebaseFirestore.instance
            .collection(COLLECTION_CHATROOMS)
            .doc(chatroomKey);

    // await chatsReference.set(chat.toMap());

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(chatsReference, chat.toMap());
      transaction.update(chatroomReference, {
        KEY_CHATROOM_LASTMESSAGE: chat.message,
        KEY_CHATROOM_LASTMESSAGETIME: DateTime.now()
      });
    });
  }

  Stream<ChatroomModel> connectChatroom(String chatroomKey) {
    return FirebaseFirestore.instance
        .collection(COLLECTION_CHATROOMS)
        .doc(chatroomKey)
        .snapshots()
        .transform(snapshotToChatroom);
  }

  var snapshotToChatroom = StreamTransformer<
      DocumentSnapshot<Map<String, dynamic>>,
      ChatroomModel>.fromHandlers(handleData: (snapshot, sink) {
    ChatroomModel chatroom = ChatroomModel.fromJson(snapshot.data()!);
    sink.add(chatroom);
  });

  Future<List<ChatModel>> getChatList(String chatroomKey) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection(COLLECTION_CHATROOMS)
        .doc(chatroomKey)
        .collection(COLLECTION_CHATS)
        .orderBy(KEY_CHAT_CREATEDDATE,descending: true)
        .limit(15)
        .get();
    List<ChatModel> chatList = [];
    snapshot.docs.forEach((docSnapshot) {
      // DocumentReference chatRef = docSnapshot.refernce;
      ChatModel chat = ChatModel.fromJson(docSnapshot.data());
      chatList.add(chat);
    });
    return chatList;
  }

  Future<List<ChatModel>> getLatestChatList(
      String chatroomKey, DocumentReference currentLatestChatRef) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection(COLLECTION_CHATROOMS)
        .doc(chatroomKey)
        .collection(COLLECTION_CHATS)
        .endBeforeDocument(await currentLatestChatRef.get())      // endAtDocumentㅇㅣㄴ가...?
        .orderBy(KEY_CHAT_CREATEDDATE,descending: true)
        .get();
    List<ChatModel> chatList = [];
    snapshot.docs.forEach((docSnapshot) {
      ChatModel chat = ChatModel.fromJson(docSnapshot.data());
      chatList.add(chat);
    });
    return chatList;
  }

  Future<List<ChatModel>> getOlderChatList(
      String chatroomKey, DocumentReference oldestChatRef) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection(COLLECTION_CHATROOMS)
        .doc(chatroomKey)
        .collection(COLLECTION_CHATS)
        .startAfterDocument(await oldestChatRef.get())
        .orderBy(KEY_CHAT_CREATEDDATE,descending: true)
        .limit(10)
        .get();
    List<ChatModel> chatList = [];
    snapshot.docs.forEach((docSnapshot) {
      ChatModel chat = ChatModel.fromJson(docSnapshot.data());
      chatList.add(chat);
    });
    return chatList;
  }

}
