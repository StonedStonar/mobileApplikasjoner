import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/auth/Authentication.dart';
import '../services/auth/FirebaseAuthenication.dart';

///The auth provider for this application.
final authProvider = StateProvider<Authentication>((ref) {
  return FirebaseAuthentication();
});
