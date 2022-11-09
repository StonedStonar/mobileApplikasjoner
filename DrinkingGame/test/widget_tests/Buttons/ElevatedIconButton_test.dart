import 'package:drinkinggame/components/buttons/ElevatedIconButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  //Test onPressed Callback for ElevatedIconButton
  testWidgets("onPressed Callback", (WidgetTester tester) async {
    var pressed = false;
    final widget = ElevatedIconButton(iconData: Icons.menu, onPressed: (context) {
      pressed = true;
    });
    
    await tester.pumpWidget(MaterialApp(home: widget));
    await tester.tap(find.byType(ElevatedIconButton));

    expect(pressed, true);
  });

  //Test if the right icon is displayed. in this case Menu icon.
  testWidgets("Test if right icon is used", (WidgetTester tester) async {
    final widget = ElevatedIconButton(iconData: Icons.menu, onPressed: (context) {});

    await tester.pumpWidget(MaterialApp(home: widget));
    final elevatedIcon = tester.widget<ElevatedIconButton>(find.byType(ElevatedIconButton));

    expect(elevatedIcon.iconData, Icons.menu);
  });

}