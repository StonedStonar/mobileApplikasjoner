import 'package:drinkinggame/model/StoreableItem.dart';

class Rule extends DatabaseItem{

  int _ruleId;

  String _ruleText;

  ///Makes an instance of a rule
  ///[ruleId] the id of the rule
  ///[ruleText] the rule as a text
  Rule({required int ruleId, required String ruleText}) : assert(ruleText.isNotEmpty), assert(ruleId > 0), _ruleId = ruleId, _ruleText = ruleText;

  ///Makes a rule from a map.
  ///[map] the map.
  Rule.fromMap({required Map<String, dynamic> map}) : assert(map.length == 2), _ruleId = int.parse(map["ruleId"]), _ruleText = map["ruleText"];

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