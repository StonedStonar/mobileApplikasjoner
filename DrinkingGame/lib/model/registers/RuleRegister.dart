import 'dart:async';

import 'package:drinkinggame/model/StoreableItem.dart';
import 'package:drinkinggame/model/exceptions/CouldNotRemoveRuleException.dart';
import 'package:drinkinggame/model/registers/Register.dart';

import '../Rule.dart';
import '../exceptions/CouldNotAddRuleException.dart';

class RuleRegister extends Register{

  List<Rule> _rules = [];

  StreamController<List<Rule>> _streamController = StreamController();

  ///Adds a rule to the register.
  ///[rule] the rule
  ///Throws [CouldNotAddRuleException] if the rule could not be added.
  void addRule(Rule rule){
    if(!_rules.contains(rule)){
      _rules.add(rule);
    }else{
      throw CouldNotAddRuleException("Rule is already in the register.");
    }
  }


  ///Removes a rule from the register.
  ///[rule] the rule to remove
  ///Throws [CouldNotRemoveRuleException] if the rule could not be removed.
  void removeRule(Rule rule){
    if(!_rules.remove(rule)){
      throw CouldNotRemoveRuleException("Rule could not be found");
    }
  }

  ///Gets the rules as a map.
  ///Returns a list with all the rules as a map.
  List<Map<String, dynamic>> getRulesAsMap(){
    List<Map<String, dynamic>> rulesAsDatabaseItems = [];
    _rules.forEach((rule) => rulesAsDatabaseItems.add(rule.toMap()));
    return rulesAsDatabaseItems;
  }

  @override
  List<DatabaseItem> getRegisterItems() {
    return _rules;
  }

  @override
  void updateStream() {
    _streamController.add(_rules);
  }

  @override
  Stream<List<Rule>> getStream() {
    return _streamController.stream;
  }
}