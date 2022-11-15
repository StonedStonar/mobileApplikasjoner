import 'dart:async';

import 'package:drinkinggame/model/StoreableItem.dart';
import 'package:drinkinggame/model/exceptions/CouldNotAddInfoContainerException.dart';
import 'package:drinkinggame/model/exceptions/CouldNotRemoveInfoContainerException.dart';
import 'package:drinkinggame/model/registers/Register.dart';

import '../questions/InfoContainer.dart';

///Represents a register where info containers can be added and removed.
class InfoContainerRegister extends Register {

  final List<InfoContainer> _infoContainers = [];

  StreamController<List<InfoContainer>> _streamController = StreamController();

  ///Adds an info container.
  ///[infoContainer] the info container to add.
  ///Throws [CouldNotAddInfoContainerException] if the info container is already in the register.
  void addInfoContainer(InfoContainer infoContainer){
    if(!_infoContainers.contains(infoContainer)){
      _infoContainers.add(infoContainer);
    }else{
      throw CouldNotAddInfoContainerException("The info container could not be added");
    }
  }

  ///Removes the info container.
  ///[infoContainer] the info container to remove.
  ///Throws [CouldNotRemoveInfoContainerException] if the info container is not in this register.
  void removeInfoContainer(InfoContainer infoContainer){
    if(!_infoContainers.remove(infoContainer)){
      throw CouldNotRemoveInfoContainerException("The info container could not be removed");
    }
  }

  @override
  List<InfoContainer> getRegisterItems() {
    return _infoContainers;
  }

  void updateStream(){
    _streamController.add(_infoContainers);
  }

  ///Gets the stream.
  Stream<List<InfoContainer>> getStream(){
    _streamController.close();
    _streamController = StreamController();
    return _streamController.stream;
  }
}