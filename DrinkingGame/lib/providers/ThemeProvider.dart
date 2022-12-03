import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///The theme provider of this app
final themeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.light);