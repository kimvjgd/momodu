import 'package:get/get.dart';
import 'package:uni_meet_dong/app/data/model/chat_model.dart';
import 'package:uni_meet_dong/app/data/model/chatroom_model.dart';
import 'package:uni_meet_dong/app/data/repository/chat_repository.dart';

class ChatController extends GetxController {
  // late ChatroomModel _chatroomModel;
  late Rx<ChatroomModel> _chatroomModel;
  RxList<ChatModel> _chatList = <ChatModel>[].obs;
  late RxString _chatroomKey;

  @override
  void onInit() {     // be careful
    ChatRepository().connectChatroom(_chatroomKey.value).listen((chatroomModel) {
      _chatroomModel(chatroomModel);

      if(_chatList.value.isEmpty){
        ChatRepository().getChatList(_chatroomKey.value).then((chatList) {
          _chatList.value.addAll(chatList);

        });
      }else {
        ChatRepository().getLatestChatList(_chatroomKey.value, _chatList[0]);
      }

    });
    super.onInit();
  }

}