import 'package:get/get.dart';
import 'package:uni_meet_dong/app/data/model/post.dart';
import 'package:uni_meet_dong/app/data/repository/post_repository.dart';

class PostController extends GetxController{
  RxList<Post> postList = <Post>[].obs;

  @override
  void onInit() {
    _loadPostList();
    super.onInit();
  }

  void _loadPostList() async {
    var myList = await PostRepository.loadPostList();
    postList.addAll(myList);
  }
}