import 'package:flutter_riverpod/flutter_riverpod.dart';

///Boolean provider to decide whether the login page or signup page
///should be displayed
///True by default
///TODO: reconsider a more fitting name
final signUpOrLoginProvider = StateProvider<bool>((ref) {
  return true;
});