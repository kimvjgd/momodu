import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uni_meet_dong/app/data/model/app_user.dart';

class UserRepository {
  static Future<AppUser?> loginUserByUid(String uid) async {
    var data = await FirebaseFirestore.instance.collection('users').where('uid',isEqualTo: uid).get();

    if(data.size==0){
      return null;
    }else {
      return AppUser.fromJson(data.docs.first.data());
    }
  }

  static Future<bool> signup(AppUser user)async {
    try{
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set(user.toMap());
      return true;
    }catch(e) {
      return false;
    }
  }
}