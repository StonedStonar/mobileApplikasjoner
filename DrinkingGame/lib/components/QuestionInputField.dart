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
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
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
              key: const Key("gameUser_input"),
          ),
          SizedBox(
            height: 15,
          ),
          ElevatedButton(
              onPressed: onButtonPress,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    CupertinoIcons.add,
                    size: 24,
                  ),
                  Text(
                    "Add",
                  )
                ],
              ))
        ],
      ),
    );
  }
}
