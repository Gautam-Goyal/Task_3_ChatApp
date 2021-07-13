import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task2/constants.dart';
import 'package:task2/helperFunctions.dart';
import 'package:task2/search.dart';

import 'authentication.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {

  // Authentication authMethods =new Authentication(FirebaseAuth.instance);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  getUserInfo() async {
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Image.asset(
        //   "assets/images/logo.png",
        //   height: 40,
        // ),
        elevation: 0.0,
        centerTitle: false,
        actions: [
          GestureDetector(
            onTap: (){
              Provider.of<Authentication>(context, listen: false).signOut();
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0)
                ,child: Icon(Icons.exit_to_app)),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => SearchScreen()
          ));
        },
      ),
    );
  }
}
