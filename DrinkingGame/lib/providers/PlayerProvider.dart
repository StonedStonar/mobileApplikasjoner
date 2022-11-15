import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/Player.dart';
import 'PlayerNotifier.dart';

final playerProvider = StateNotifierProvider<PlayerNotifier, List<Player>>((ref) {
    return PlayerNotifier();
});