import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomGameAlert extends ConsumerWidget{

  TextEditingController _titleController = TextEditingController();

  TextEditingController _idController = TextEditingController();

  TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: _makeContentsOfColumn(context),
    );
  }

  ///Makes the fields for the alert.
  ///[context] the build context
  ///Returns the list of widgets.
  List<Widget> _makeContentsOfColumn(BuildContext context){
    List<Widget> widgets = [];
    //widgets.add()

    return widgets;
  }

  TextField makeTextField(TextEditingController controller ){
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: "halla";
      ),
    );
  }

}