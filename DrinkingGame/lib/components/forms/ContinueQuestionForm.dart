import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../CustomText.dart';

class ContinueQuestionForm extends StatelessWidget {
  String mainTitle;

  String subTitle;

  Function yesFunction;

  Function noFunction;

  ///Makes an instance of the continue question form.
  ///[mainTitle] the main title
  ///[subTitle] the sub title
  ///[yesFunction] the yes function
  ///[noFunction] the no function
  ContinueQuestionForm(
      {required this.mainTitle,
      required this.subTitle,
      required this.yesFunction,
      required this.noFunction,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: getFormItems(context),
    );
  }

  ///Gets the form items
  ///[context] the build context
  ///Returns the form items
  List<Widget> getFormItems(BuildContext context) {
    return [
      CustomText(text: mainTitle, fontSize: 30, fontWeight: FontWeight.w500),
      SizedBox(height: 10,),
      CustomText(text: subTitle, fontSize: 20, fontWeight: FontWeight.w300),
      SizedBox(height: 50,),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
              onPressed: () => yesFunction(),
              child: Column(
                children: const [
                  SizedBox(height: 5),
                  Icon(
                    CupertinoIcons.check_mark,
                    size: 60,
                  ),
                  Text(
                    "Yes",
                    style: TextStyle(fontSize: 25),
                  )
                ],
              )),
          SizedBox(
            width: 80,
          ),
          TextButton(
              onPressed: () => noFunction(),
              child: Column(
                children: const [
                  SizedBox(height: 5),
                  Icon(CupertinoIcons.xmark, size: 60),
                  Text(
                    "No",
                    style: TextStyle(fontSize: 25),
                  )
                ],
              )),
        ],
      ),
    ];
  }
}
