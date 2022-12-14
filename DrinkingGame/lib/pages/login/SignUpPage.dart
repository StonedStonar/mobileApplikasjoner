import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/forms/AuthenticationForm.dart';

class SignUpPage extends ConsumerWidget {

  ///Makes an instance of the signup page
  SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AuthenticationForm();
  }
}