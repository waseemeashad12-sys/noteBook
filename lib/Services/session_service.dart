import 'package:get/get.dart';

class SessionService {
  static int? currentUserId;
  static RxnString currentUserName = RxnString();
  static RxnString currentUserEmail = RxnString();


  static void setSession(int id, String name , String email) {
    currentUserId = id;
    currentUserName.value = name;
    currentUserEmail.value = email;
  }


  static void clearSession() {
    currentUserId = null;
    currentUserName.value = null;
    currentUserEmail.value = null;
  }
}
