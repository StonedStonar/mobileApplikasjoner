import 'package:firebase_auth/firebase_auth.dart';

///Represents a basic authentication class. All the base methods needed.
abstract class Authentication{

  ///Gets the current logged in user.
  ///Returns the current logged in user.
  User?  get currentUser;

  ///Signs the user into anonymous mode.
  Future<User?> signInAnonymously();

  ///Sings the user into an google account.
  Future<User> signInToGoogle();

  ///Signs the user out.
  Future<void> signOut();

  ///Notifies about changes to the users signing state.
  Stream<User?> authStateChanges();

  ///Logs a user into firebase with email and password.
  ///[email] the mail address of the user.
  ///[password] the password of the user.
  ///Returns a user if credentials match them.
  Future<User?> signInWithEmailAndPassword(String email, String password);

  ///Makes a new user in the firebase.
  ///[email] the email of the user.
  ///[password] the password of the user.
  ///Returns a user if the email is not taken.
  Future<User?> createUserWithEmailAndPassword(String email, String password);
}