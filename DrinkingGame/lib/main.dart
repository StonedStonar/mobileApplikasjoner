import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'App.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();   
  await Firebase.initializeApp();
  runApp(ProviderScope(child: App()));
}
