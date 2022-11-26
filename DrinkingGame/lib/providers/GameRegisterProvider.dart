import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/registers/GameRegister.dart';

final gameRegisterProvider = StateProvider<GameRegister>((ref) => GameRegister());
