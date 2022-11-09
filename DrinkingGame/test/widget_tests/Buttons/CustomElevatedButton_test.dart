import 'package:drinkinggame/components/buttons/CustomElevatedButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  // Testing to show if CustomRaisedButton is displayed/created correctly
  testWidgets("CustomRaisedButton is displayed correctly", (WidgetTester tester) async {
    final widget = CustomElevatedButton(widget: Text(""), borderRadius: 4.0, color: Colors.white, onPressed: () {});

    await tester.pumpWidget(MaterialApp(home: widget));

    expect(find.byType(CustomElevatedButton), findsOneWidget);
  });

  // Testing the Callback for the button.
  testWidgets("onPressed Callback", (WidgetTester tester) async {
    var pressed = false;
    final widget = CustomElevatedButton(widget: Text(""), borderRadius: 4.0, color: Colors.white, onPressed: () {
      pressed = true;
    });

    await tester.pumpWidget(MaterialApp(home: widget));
    await tester.tap(find.byType(ElevatedButton));

    expect(pressed, true);
  });

  // Testing the button text inside the button.
  testWidgets("Button text", (WidgetTester tester) async {
    final widget = CustomElevatedButton(widget: Text("When Clicked"), borderRadius: 4.0, color: Colors.white, onPressed: () {});

    await tester.pumpWidget(MaterialApp(home: widget));

    expect(find.text("When Clicked"), findsOneWidget);
  });

  // Testing the background color of a button.
  testWidgets("Background color for button", (WidgetTester tester) async {
    final widget = CustomElevatedButton(widget: Text(""), borderRadius: 4.0, color: Colors.blue, onPressed: () {});

    await tester.pumpWidget(MaterialApp(home: widget));
    final customElevatedButton = tester.widget<CustomElevatedButton>(find.byType(CustomElevatedButton));

    expect(customElevatedButton.color, Colors.blue);
  });

  // Testing the circular border shape for the button.
  testWidgets("Circular border shape", (WidgetTester tester) async {
    final widget = CustomElevatedButton(widget: Text(""), borderRadius: 4.0, color: Colors.blue, onPressed: () {});

    await tester.pumpWidget(MaterialApp(home: widget));
    final customElevatedButton = tester.widget<CustomElevatedButton>(find.byType(CustomElevatedButton));

    expect(customElevatedButton.borderRadius, 4.0);
  });
  

}