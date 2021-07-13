import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:task2/chatRoomsScreen.dart';
import 'package:task2/helperFunctions.dart';
import 'package:task2/iconandtext.dart';
import 'package:flutter/material.dart';
import 'package:task2/database.dart';
import 'authentication.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController loginUsernameController=TextEditingController();
  final TextEditingController loginPasswordController=TextEditingController();
  final TextEditingController signupUsernameController=TextEditingController();
  final TextEditingController signupPasswordController=TextEditingController();
  final TextEditingController signupNameOfUserController=TextEditingController();
  String nameOfUser;
  String loginUsername;
  String loginPassword;
  String signupUsername;
  String signupPassword;
  GlobalKey<FormState> formkey1= GlobalKey<FormState>();
  GlobalKey<FormState> formkey2= GlobalKey<FormState>();
  bool _isloading=false;

  int _pageState = 0;

  var _backgroundColor = Colors.white;
  var _headingColor = Color(0xFF008000);

  double _headingTop = 100;

  double _loginWidth = 0;
  double _loginHeight = 0;
  double _loginOpacity = 1;

  double _loginYOffset = 0;
  double _loginXOffset = 0;
  double _registerYOffset = 0;
  double _registerHeight = 0;

  double windowWidth = 0;
  double windowHeight = 0;

  // bool _keyboardVisible = false;

  DatabaseMethods databaseMethods =new DatabaseMethods();
  QuerySnapshot userInfo;
  @override
  void initState() {
    super.initState();
    signupNameOfUserController.addListener(() {setState(() {});});
    loginPasswordController.addListener(() {setState(() {});});
    loginUsernameController.addListener(() {setState(() {});});
    signupPasswordController.addListener(() {setState(() {});});
    signupUsernameController.addListener(() {setState(() {});});
  }

  @override
  Widget build(BuildContext context) {

    windowHeight = MediaQuery.of(context).size.height;
    windowWidth = MediaQuery.of(context).size.width;

    _loginHeight = windowHeight - 270;
    _registerHeight = windowHeight - 270;

    switch(_pageState) {
      case 0:
        _backgroundColor = Colors.white;
        _headingColor = Color(0xFFB40284A);

        _headingTop = 100;

        _loginWidth = windowWidth;
        _loginOpacity = 1;

        _loginYOffset = windowHeight;
        _loginHeight = MediaQuery.of(context).viewInsets.bottom!=0 ? windowHeight : windowHeight - 270;

        _loginXOffset = 0;
        _registerYOffset = windowHeight;
        break;
      case 1:
        _backgroundColor = Color(0xFF008000);
        _headingColor = Colors.white;

        _headingTop = 90;

        _loginWidth = windowWidth;
        _loginOpacity = 1;

        _loginYOffset = MediaQuery.of(context).viewInsets.bottom!=0 ? 130 : 260;
        _loginHeight = MediaQuery.of(context).viewInsets.bottom!=0 ? windowHeight : windowHeight - 240;

        _loginXOffset = 0;
        _registerYOffset = windowHeight;
        break;
      case 2:
        _backgroundColor = Color(0xFF008000);
        _headingColor = Colors.white;

        _headingTop = 80;

        _loginWidth = windowWidth - 40;
        _loginOpacity = 0.7;

        _loginYOffset = MediaQuery.of(context).viewInsets.bottom!=0 ? 115 : 240;
        _loginHeight = MediaQuery.of(context).viewInsets.bottom!=0 ? windowHeight : windowHeight - 240;

        _loginXOffset = 20;
        _registerYOffset = MediaQuery.of(context).viewInsets.bottom!=0 ? 140 : 260;
        _registerHeight = MediaQuery.of(context).viewInsets.bottom!=0 ? windowHeight : windowHeight - 240;
        break;
    }

    return Scaffold( //?Added after error -'No Material Widget' Later showing widget overflowing on login screen
      body: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: (){
              setState(() {
                _pageState=0;
              });
            },
            child: AnimatedContainer(
                curve: Curves.fastLinearToSlowEaseIn,
                duration: Duration(
                    milliseconds: 1000
                ),
                color: _backgroundColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _pageState = 0;
                        });
                      },
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            AnimatedContainer(
                              curve: Curves.fastLinearToSlowEaseIn,
                              duration: Duration(
                                  milliseconds: 1000
                              ),
                              margin: EdgeInsets.only(
                                top: _headingTop,
                              ),
                              child: Text(
                                "Task 2",
                                style: TextStyle(
                                    color: _headingColor,
                                    fontSize: 28
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(20),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 32
                              ),
                              child: Text(
                                "Task 2 login app",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: _headingColor,
                                    fontSize: 16
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    // Container(
                    //   padding: EdgeInsets.symmetric(
                    //       horizontal: 32
                    //   ),
                    //   child: Center(
                    //     child: Image.asset("assets/images/imageedit_1_4188329228.png"),
                    //   ),
                    // ),
                    Container(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            if(_pageState != 0){
                              _pageState = 0;
                            } else {
                              _pageState = 1;
                            }
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.all(32),
                          padding: EdgeInsets.all(20),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Color(0xFF29a329),
                              borderRadius: BorderRadius.circular(50)
                          ),
                          child: Center(
                            child: Text(
                              "Get Started",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
            ),
          ),
          AnimatedContainer(
            padding: EdgeInsets.all(32),
            width: _loginWidth,
            height: _loginHeight,
            curve: Curves.fastLinearToSlowEaseIn,
            duration: Duration(
                milliseconds: 1000
            ),
            transform: Matrix4.translationValues(_loginXOffset, _loginYOffset, 1),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(_loginOpacity),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)
                )
            ),
            // child: Column(
            //   children: <Widget>[
            child:Form(
              key: formkey1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Text(
                      "Login To Continue",
                      style: TextStyle(
                        color: Colors.black,
                          fontSize: 20
                      ),
                    ),
                  ),
                  EmailWithIcon(
                    icon: Icons.email,
                    hint: "Enter Email",
                    keyboard: TextInputType.emailAddress,
                    emailController: loginUsernameController,
                  ),
                  PasswordWithIcon(
                    icon: Icons.vpn_key,
                    hint: "Enter Password",
                    keyboard: TextInputType.text,
                    passwordController: loginPasswordController,
                  ),
                  GestureDetector(
                    onTap:() async {
                      // final firebaseUser = context.watch<User>();
                      if (formkey1.currentState.validate() == true) {
                        HelperFunctions.saveUserEmailSharedPreference(loginUsernameController.text);
                        var result= await Provider.of<Authentication>(context, listen: false)
                            .signIn(
                            email: loginUsernameController.text,
                            password: loginPasswordController.text
                        ).then((value){
                          if(value!=null){
                            databaseMethods.getUserByEmail(loginUsernameController.text).then((value){
                              userInfo =value;
                              HelperFunctions.saveUserEmailSharedPreference(userInfo.docs[0].data());
                            });
                            HelperFunctions.saveUserLoggedInSharedPreference(true);
                            HelperFunctions.saveUserEmailSharedPreference(loginUsernameController.text);
                          }
                        });
                        // if (firebaseUser != null) {
                          setState(() {
                            Fluttertoast.showToast(msg: result.toString(),
                                toastLength: Toast.LENGTH_SHORT);
                          });
                        // }
                        // else {
                        //   setState(() {
                        //     Fluttertoast.showToast(msg: result.toString(),
                        //         toastLength: Toast.LENGTH_SHORT);
                        //   });
                        // }
                      }
                    },
                    child: PrimaryButton(
                      btnText: "Login",
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _pageState = 2;
                      });
                    },
                    child: OutlineBtn(
                      btnText: "Create New Account",
                    ),
                  )
                ],
              ),
            ),
            // Column(
            //   children: <Widget>[
            //
            //   ],
            // ),

          ),
          AnimatedContainer(
            height: _registerHeight,
            padding: EdgeInsets.all(32),
            curve: Curves.fastLinearToSlowEaseIn,
            duration: Duration(
                milliseconds: 1000
            ),
            transform: Matrix4.translationValues(0, _registerYOffset, 1),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)
                )
            ),
            // child: Column(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: <Widget>[
            child:Form(
              key: formkey2,
              child:Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Text(
                      "Create a New Account",
                      style: TextStyle(
                        color: Colors.black,
                          fontSize: 20
                      ),
                    ),
                  ),
                  UsernameWithIcon(
                    icon: Icons.account_circle_sharp,
                    hint: "Enter Username",
                    nameOfUserController: signupNameOfUserController,
                  ),
                  EmailWithIcon(
                    icon: Icons.email,
                    hint: "Enter Email",
                    keyboard: TextInputType.emailAddress,
                    emailController: signupUsernameController,
                  ),
                  PasswordWithIcon(
                    icon: Icons.vpn_key,
                    hint: "Enter Password",
                    keyboard: TextInputType.text,
                    passwordController: signupPasswordController,
                  ),
                  GestureDetector(
                    onTap:() async {
                      if (formkey2.currentState.validate() == true) {
                        var result = await Provider.of<Authentication>(
                            context, listen: false).signUp(
                            email: signupUsernameController.text,
                            password: signupPasswordController.text
                        ).then((value){
                          if(value!=null){
                            Map<String ,String> userInfoMap ={
                              "name":signupNameOfUserController.text,
                              "email":signupUsernameController.text
                            };
                            HelperFunctions.saveUserNameSharedPreference(signupNameOfUserController.text);
                            HelperFunctions.saveUserEmailSharedPreference(signupUsernameController.text);

                            databaseMethods.uploadUserInfo(userInfoMap);
                            HelperFunctions.saveUserLoggedInSharedPreference(true);
                            Navigator.pushReplacement(context, MaterialPageRoute(
                                builder: (context) => ChatRoom()
                            ));
                          }
                        });
                        setState(() {
                          _isloading = true;
                          _pageState = 1;
                        });
                        // if (firebaseUser != null) {
                        //   setState(() {
                        //     _isloading = false;
                        //     Fluttertoast.showToast(msg: "Signed Up!",
                        //         toastLength: Toast.LENGTH_SHORT);
                        //   });
                        // }
                        // else {
                        //   setState(() {
                        //     Fluttertoast.showToast(msg: result.toString(),
                        //         toastLength: Toast.LENGTH_SHORT);
                        //     _isloading = false;
                        //   });
                        // }
                      }
                    },
                    child: PrimaryButton(
                      btnText: "Create Account",
                    ),
                  ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _pageState = 1;
                      });
                    },
                    child: OutlineBtn(
                      btnText: "Back To Login",
                    ),
                  )
                ],
              ),
            ),
            // Column(
            //   children: <Widget>[
            //   ],
            // ),
            //   ],
            // ),
          ),
          !_isloading?SizedBox.shrink():Center(child: CircularProgressIndicator())
        ],
      ),
    );
  }

  showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 7),child:Text("Loading..." )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }
}