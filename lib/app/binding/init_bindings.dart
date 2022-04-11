import 'package:get/get.dart';
import 'package:uni_meet_dong/app/controller/auth_controller.dart';
import 'package:uni_meet_dong/app/controller/bottom_nav_controller.dart';
import 'package:uni_meet_dong/app/controller/chatroom_controller.dart';
import 'package:uni_meet_dong/app/controller/comment_controller.dart';
import 'package:uni_meet_dong/app/controller/post_controller.dart';

class InitBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController(), permanent: true);
    Get.put(BottomNavController(), permanent: true);
  }



  // static BottomNavBinding() {
  //   Get.put(BottomNavController(), permanent: true);
  // }

  static additionalBinding() {
    // Get.put(MypageController(), permanent: true);
    Get.put(PostController(), permanent: true);
    Get.put(ChatroomController(), permanent: true);
  }

  static commentBinding() {
    // Get.put(CommentController(),permanent: false);
    Get.lazyPut(() => CommentController());
  }
}