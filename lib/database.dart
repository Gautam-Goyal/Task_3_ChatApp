import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{

  getUserByName(String username) async {
    return await FirebaseFirestore.instance.collection("users").where("name", isEqualTo: username).get();
  }

  getUserByEmail (String useremail) async {
    return await FirebaseFirestore.instance.collection("users").where("email", isEqualTo: useremail).get();
  }

  uploadUserInfo(userMap){
    FirebaseFirestore.instance.collection("users").add(userMap);
  }

  createChatRoom(String chatRoomId, chatRoomMap){
    FirebaseFirestore.instance.collection("ChatRoom").doc(chatRoomId).set(chatRoomMap).catchError((e){
      print(e.toString());
    });
  }
}