
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/database/Database.dart';

///The database provider
final databaseProvider = StateProvider<Database?>((ref){
  return null;
});
