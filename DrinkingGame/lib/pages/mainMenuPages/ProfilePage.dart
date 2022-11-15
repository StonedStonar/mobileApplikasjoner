

import 'package:drinkinggame/App.dart';
import 'package:drinkinggame/components/overlays/MainMenu.dart';
import 'package:drinkinggame/services/auth/Authentication.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/AppBars.dart';
import '../../services/database/Database.dart';

class ProfilePage extends ConsumerWidget{


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: makeNormalAppBar("Profile", context),
      body: _buildContent(ref),
      drawer: MainMenu(),
    );
  }

  ///Builds the content of the page
  ///[widgetRef] the widget ref.
  ///Returns the widget.
  Widget _buildContent(WidgetRef widgetRef){
    Authentication? authentication = widgetRef.watch(authProvider);
    String username = authentication?.currentUser?.displayName == null ? "No username" : authentication!.currentUser!.displayName!;
    return Column(
      children: [
        Text(username),
      ],
    );
  }


}