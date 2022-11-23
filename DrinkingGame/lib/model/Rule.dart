import 'package:drinkinggame/model/StoreableItem.dart';

class Rule extends DatabaseItem{

  final int _ruleId;

  final String _ruleText;

  final String _punishment;

  ///Makes an instance of a rule
  ///[ruleId] the id of the rule
  ///[ruleText] the rule as a text
  ///[punishment] the punishment.
  Rule({required int ruleId, required String ruleText, required String punishment}) : assert(ruleText.isNotEmpty), assert(ruleId > 0), _ruleId = ruleId, _ruleText = ruleText, _punishment = punishment;

  ///Makes a rule from a map.
  ///[map] the map.
  Rule.fromMap({required Map<String, dynamic> map}) : assert(map.length == 3), _ruleId = int.parse(map["ruleId"]), _ruleText = map["ruleText"], _punishment = map["punishment"];

  ///Gets the rule as text with format id + ruleText
  ///Returns the rule as text
  String _getRuleAsText(){
    return "$_ruleId $_ruleText";
  }

  String getRuleText() {
    return _ruleText;
  }

  ///Gets the punishment for the rule
  ///Returns the punishment
  String getPunishment(){
    return _punishment;
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
      "punishment" : _punishment,
    };
  }
}