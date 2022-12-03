import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/registers/GameRegister.dart';

///the game register provider of this app
final gameRegisterProvider = StateProvider<GameRegister>((ref) => GameRegister());
