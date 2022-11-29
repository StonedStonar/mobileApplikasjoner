import 'package:drinkinggame/components/GameSlidingButton.dart';
import 'package:drinkinggame/components/buttons/GameButton.dart';
import 'package:drinkinggame/model/games/InfoGame.dart';
import 'package:drinkinggame/model/games/OpenQuestionGame.dart';
import 'package:drinkinggame/model/games/StatementGame.dart';
import 'package:drinkinggame/model/registers/GameRegister.dart';
import 'package:drinkinggame/pages/GameSelectionPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  testWidgets("A game button can be created with a new InfoGame", (widgetTester) async {

    ///Create a new info game
    InfoGame infoGame = InfoGame(
        gameName: "Info",
        shortDescription: "InfoGameShortDescription",
        longDescription: "InfoGameLongDescription");

    ///create a gameButton for a Info game
    GameButton gameButtonInfo = GameButton(game: infoGame, onPressed: () {});

    ///Create the info gameButton
    await widgetTester.pumpWidget(
      ProviderScope(
          child: MaterialApp(
            home: gameButtonInfo,
          ))
    );

    ///See if text widgets can be found
    final infoGameNameFinder = find.text("Info");
    final infoShortDescriptionFinder = find.text("InfoGameShortDescription");

    ///Assert that text widgets are found
    expect(infoGameNameFinder, findsOneWidget);
    expect(infoShortDescriptionFinder, findsOneWidget);
  });

  testWidgets("A game button can be created with a new StatementGame", (widgetTester) async {

    ///Create a new statement game
    StatementGame statementGame = StatementGame(
        gameName: "Statement",
        shortDescription: "StatementGameShortDescription",
        longDescription: "StatementGameLongDescription");

    ///create a gameButton for a statement game
    GameButton gameButtonStatement = GameButton(game: statementGame, onPressed: () {});

    ///Create the statement gameButton
    await widgetTester.pumpWidget(
        ProviderScope(
            child: MaterialApp(
              home: gameButtonStatement,
            ))
    );

    ///See if text widgets can be found
    final statementGameNameFinder = find.text("Statement");
    final statementShortDescriptionFinder = find.text("StatementGameShortDescription");

    ///Assert that text widgets are found
    expect(statementGameNameFinder, findsOneWidget);
    expect(statementShortDescriptionFinder, findsOneWidget);
  });


  testWidgets("A game button can be created with a new OpenQuestionGame", (widgetTester) async {

    ///Create a new statement game
    OpenQuestionGame openQuestionGame = OpenQuestionGame(
        gameName: "OpenQuestion",
        shortDescription: "OpenQuestionGameShortDescription",
        longDescription: "OpenQuestionGameLongDescription");

    ///create a gameButton for a statement game
    GameButton gameButtonOpenQuestion = GameButton(game: openQuestionGame, onPressed: () {});

    ///Create the statement gameButton
    await widgetTester.pumpWidget(
        ProviderScope(
            child: MaterialApp(
              home: gameButtonOpenQuestion,
            ))
    );

    ///See if text widgets can be found
    final openQuestionGameFinder = find.text("OpenQuestion");
    final openQuesttionShortDescriptionFinder = find.text("OpenQuestionGameShortDescription");

    ///Assert that text widgets are found
    expect(openQuestionGameFinder, findsOneWidget);
    expect(openQuesttionShortDescriptionFinder, findsOneWidget);
  });
  ///TODO: create test for openQuestionGame
}