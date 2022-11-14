import 'package:drinkinggame/model/StoreableItem.dart';

class Rule extends DatabaseItem{

  int _ruleId;

  String _ruleText;

  ///Makes an instance of a rule
  ///[ruleId] the id of the rule
  ///[ruleText] the rule as a text
  Rule({required int ruleId, required String ruleText}) : assert(ruleText.isNotEmpty), assert(ruleId > 0), _ruleId = ruleId, _ruleText = ruleText;

  ///Gets the rule as text with format id + ruleText
  ///Returns the rule as text
  String getRuleAsText(){
    return "$_ruleId $_ruleText";
  }

  @override
  String getItemId() {
    return _ruleId.toString();
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "ruleId" : _ruleId,
      "ruleText" : _ruleText,
    };
  }

}