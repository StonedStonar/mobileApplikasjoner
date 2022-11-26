import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/auth/Authentication.dart';
import '../services/auth/FirebaseAuthenication.dart';

final authProvider = StateProvider<Authentication>((ref) {
  return FirebaseAuthentication();
});
