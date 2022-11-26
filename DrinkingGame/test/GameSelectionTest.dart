import 'package:drinkinggame/pages/GameSelectionPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  testWidgets("", (widgetTester) async {
    await widgetTester.pumpWidget(
      ProviderScope(
          child: MaterialApp(
            home: GameSelectionPage(),
          ))
    )
  });
}