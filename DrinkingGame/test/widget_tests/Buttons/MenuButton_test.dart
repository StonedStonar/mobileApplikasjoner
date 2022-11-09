import 'package:drinkinggame/components/buttons/MenuButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  //Check the icon
  testWidgets("Test if icon is correct", (WidgetTester tester) async {
    final widget = MenuButton(
        buttonText: "buttonText",
        icon: Icons.games,
        onPressed: () {}
    );

    await tester.pumpWidget(MaterialApp(home: widget));
    final icon = tester.widget<MenuButton>(find.byType(MenuButton));

    expect(icon.icon, Icons.games);
  });

}