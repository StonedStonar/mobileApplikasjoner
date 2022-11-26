import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/games/Game.dart';

final gameProvider = StateProvider<Game?>((ref) => null);