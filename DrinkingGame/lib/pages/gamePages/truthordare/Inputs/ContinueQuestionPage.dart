import 'package:drinkinggame/components/CustomText.dart';
import 'package:drinkinggame/pages/gamePages/truthordare/Inputs/CustomQuestionsPage.dart';
import 'package:drinkinggame/pages/gamePages/truthordare/TruthOrDarePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../components/forms/ContinueQuestionForm.dart';

class ContinueQuestionPage extends StatelessWidget {
  const ContinueQuestionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 70, 15, 5),
      child: ContinueQuestionForm(mainTitle: 'Do you want to add truth(s) or dare(s)?',
        subTitle: 'If nor truth or dares is added only a default question set will be used',
        yesWidget: TruthOrDarePage(),
        noWidget: TruthOrDarePage(),),
    );
  }

}
