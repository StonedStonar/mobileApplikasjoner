import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../CustomText.dart';

///Represents a game input form.
class GameInputForm extends ConsumerWidget{


  String formTitle;

  Widget textField;

  Widget? underWidget;

  ///Makes an instance of the game input form.
  ///[formTitle] the title of the form
  ///[textField] the text field of the form.
  GameInputForm({super.key, required this.formTitle, required this.textField, this.underWidget});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 65, 5, 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: buildMainContent(),
          )
      ),
    );
  }

  ///Makes the main content of the form.
  ///Returns a list with widgets.
  List<Widget> buildMainContent(){
    List<Widget> widgets = [];
    widgets.add(CustomText(text: formTitle,
        fontSize: 30, fontWeight: FontWeight.w600));
    widgets.add(SizedBox(height: 20));
    widgets.add(textField);
    underWidget != null ? widgets.add(underWidget!) : null;


    return widgets;
  }


}