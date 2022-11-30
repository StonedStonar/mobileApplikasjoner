import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///Makes an input question field with a add button.
class QuestionInputField extends ConsumerWidget {

  String hintTextField;

  String? errorText;

  TextEditingController fieldController;

  VoidCallback onTextFieldChanged;

  VoidCallback onEditingComplete;

  VoidCallback onButtonPress;

  ///Makes an instance of the input question field.
  ///[hintTextField] the hint text of the textfield.
  ///[fieldController] the controller
  ///[onTextFieldChanged] function for when the textfield changes
  ///[onEditingComplete] function for editing complete
  ///[onButtonPress] function for the add button
  QuestionInputField({super.key, required this.hintTextField, this.errorText , required this.fieldController, required this.onTextFieldChanged,
    required this.onEditingComplete, required this.onButtonPress});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: EdgeInsets.fromLTRB(55, 0, 0, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: TextField(
                style: TextStyle(fontSize: 20),
                controller: fieldController,
                textAlign: TextAlign.center,
                onChanged: (username) => onTextFieldChanged(),
                decoration: InputDecoration(
                  hintText: "Enter ${hintTextField}",
                  errorText: errorText,
                ),
                autocorrect: false,
                textInputAction: TextInputAction.done,
                onEditingComplete: () => onEditingComplete(),
                key: const Key("gameUser_input")),
          ),
          TextButton(
              onPressed: onButtonPress,
              child: Column(
                children: const [
                  SizedBox(height: 11),
                  Icon(
                    CupertinoIcons.add,
                    size: 30,
                  ),
                  Text(
                    "Add",
                    style: TextStyle(fontSize: 14),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
