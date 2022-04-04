import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_meet_dong/app/binding/init_bindings.dart';
import 'package:uni_meet_dong/app/ui/page/screen_index/index_screen.dart';
import 'package:uni_meet_dong/app/ui/page/screen_index/post/screen/post_add_screen.dart';
import 'package:uni_meet_dong/root_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialBinding: InitBinding(),
    home: RootPage(),));
}

// sudo arch -x86_64 gem install ffi 다운받고
// ios folder로 가서 arch -x86_64 pod install --repo-update
// ->platform 10.0으로 바꿔라
