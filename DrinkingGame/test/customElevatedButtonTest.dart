import 'package:drinkinggame/components/buttons/CustomElevatedButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  //Test if the button gets created correctly.
  testWidgets("Correct creation of a button", (WidgetTester tester) async {
    await tester.pumpWidget(
        MaterialApp(home: CustomElevatedButton(
            widget: Text(""),
            onPressed: () {},
            color: Colors.white70,
        ),
        ));

    final button = find.byType(ElevatedButton);
    expect(button, findsOneWidget);
  });

  //Test to check if the text inside the button matches the expected text.
  testWidgets("Test Text inside button", (WidgetTester tester) async {
    await tester.pumpWidget(
        MaterialApp(home: CustomElevatedButton(
          widget: Text("Smash that like button"),
          onPressed: () {},
          color: Colors.white70,
        ),
        ));

    expect(find.text("Smash that like button"), findsOneWidget);
  });

  //Test to check if the button get pressed.
  testWidgets("OnPressed callback", (WidgetTester tester) async {
    var pressed = false;
    await tester.pumpWidget(
        MaterialApp(home: CustomElevatedButton(
          widget: Text("Smash that like button"),
          onPressed: () => pressed = true,
          color: Colors.white70,
        ),
        ));

    final button = find.byType(ElevatedButton);
    await tester.tap(button);
    expect(pressed, true);
  });

}