
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/database/Database.dart';

final databaseProvider = StateProvider<Database?>((ref){
  return null;
});
