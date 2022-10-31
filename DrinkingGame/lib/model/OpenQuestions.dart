import 'package:drinkinggame/model/Questions.dart';

class OpenQuestion extends Questions {
  bool? used = false;

  bool? isUsed() {
    //insert logic
    return this.used;
  }
}
