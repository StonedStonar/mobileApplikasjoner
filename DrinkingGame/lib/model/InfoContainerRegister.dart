import 'package:drinkinggame/model/exceptions/CouldNotAddInfoContainerException.dart';
import 'package:drinkinggame/model/exceptions/CouldNotRemoveInfoContainerException.dart';

import 'InfoContainer.dart';

///Represents a register where info containers can be added and removed.
class InfoContainerRegister {

  final List<InfoContainer> _infoContainers = [];

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

  ///Gets all the infocontainers.
  ///Returns the list with all infocontainers.
  List<InfoContainer> getAllInfoContainers(){
    return _infoContainers;
  }
}