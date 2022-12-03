import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/games/Game.dart';

///The game provider of this app
final gameProvider = StateProvider<Game?>((ref) => null);