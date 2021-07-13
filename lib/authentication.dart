import 'package:firebase_auth/firebase_auth.dart';

import 'modal/user.dart';

class Authentication{
  final FirebaseAuth _firebaseAuth;
  Authentication(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  AppUser _userfromFirebaseUser(User user){
    return user !=null ? AppUser(uid: user.uid) :null;
  }
  Future<void> signOut() async{
    await _firebaseAuth.signOut();
  }
  Future signIn({String email, String password})async{
    try{
      UserCredential result= await _firebaseAuth.signInWithEmailAndPassword(email: email, password:password);
      User firebaseUser=result.user;
      return _userfromFirebaseUser(firebaseUser);
    } on FirebaseAuthException catch(e){
      return e.message;
    }
  }

  Future signUp({String email, String password}) async {
    try{
      UserCredential result= await _firebaseAuth.createUserWithEmailAndPassword(email: email, password:password);
      User firebaseUser=result.user;
      return _userfromFirebaseUser(firebaseUser);
    } on FirebaseAuthException catch(e){
      return e.message;
    }
  }
}