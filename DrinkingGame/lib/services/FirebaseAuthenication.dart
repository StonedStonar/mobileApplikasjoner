import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


import 'Authentication.dart';

///Represents the basic methods of authentication in the application.
///Used instead of calling the firebase authentication everywhere.
class FirebaseAuthentication implements Authentication{

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  User?  get currentUser => _firebaseAuth.currentUser;

  @override
  Future<User?> signInAnonymously() async {
    UserCredential userCredential = await _firebaseAuth.signInAnonymously();
    return userCredential.user;
  }

  @override
  Future<User> signInToGoogle() async{
    GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if(googleUser != null){
      GoogleSignInAuthentication googleAuthentication = await googleUser.authentication;
      if(googleAuthentication.idToken != null){
        UserCredential userCredential = await _firebaseAuth.signInWithCredential(GoogleAuthProvider.credential(idToken: googleAuthentication.idToken, accessToken: googleAuthentication.idToken));
        return userCredential.user!;
      }else{
        throw FirebaseAuthException(code: "ERROR_MISSING_GOOGLE_ID_TOKEN", message: "Missing Google ID token");
      }
    }else{
      throw FirebaseAuthException(code: "ERROR_ABORTED_BY_USER", message: "Sign in aborted by user");
    }

  }

  @override
  Future<void> signOut() async{
    GoogleSignIn googleSignIn = GoogleSignIn();
    googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }

  @override
  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

  @override
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    UserCredential userCredential = await _firebaseAuth.signInWithCredential(
      EmailAuthProvider.credential(email: email, password: password),
    );
    return userCredential.user;
  }

  @override
  Future<User?> createUserWithEmailAndPassword(String email, String password) async {
    UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
  }


}