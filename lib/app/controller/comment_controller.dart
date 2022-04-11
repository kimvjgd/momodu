import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CommentController extends GetxController {

    TextEditingController commentTextController = TextEditingController();

  // @override
  // void dispose() {
  //   commentTextController.dispose();
  //   commentTextController.text = '';
  //   super.dispose();
  // }

  @override
  void onClose() {
    commentTextController.text = '';
    commentTextController.dispose();
    super.onClose();
  }

    @override
    void refresh() {

    }

}