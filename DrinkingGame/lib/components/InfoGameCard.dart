import 'package:drinkinggame/model/questions/InfoContainer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

///Represents a info game card.
class InfoGameCard extends ConsumerWidget {
  ///Makes an instance of the info game card.
  ///[infoContainer] the info container.
  InfoGameCard({required this.infoContainer,});

  final InfoContainer infoContainer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget background = Text("Hei");
    return buildContent();
  }


  Widget buildContent(){
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Color(0xFFD9D9D9),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Text(
                "${infoContainer.getItemId()} - ${infoContainer.getTitle()}",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              infoContainer.getDescription(),
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
