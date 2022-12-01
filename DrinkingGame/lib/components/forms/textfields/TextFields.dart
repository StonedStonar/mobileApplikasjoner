
import 'package:flutter/material.dart';

///A textfield for a username input
TextField buildUsernameTextField(
    TextEditingController controller,
    FocusNode focusNode,
    Function onChanged,
    String labelText,
    String hintText,
    bool errorText,
    bool isLoading,
    Function onEditingComplete,
    String keyValue) {
  return TextField(
      style: TextStyle(fontSize: 20),
      controller: controller,
      focusNode: focusNode,
      onChanged: (username) => onChanged(),
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        errorText: errorText ? "Username has to be 3-20 alphabetic characters" : null,
      ),
      enabled: !isLoading,
      autocorrect: false,
      textInputAction: TextInputAction.go,
      onEditingComplete: () => onEditingComplete(),
      key: Key(keyValue)
  );
}

///A textfield for an email input
TextField buildEmailTextField(
    TextEditingController controller,
    FocusNode focusNode,
    Function onChanged,
    String labelText,
    String hintText,
    bool errorText,
    bool isLoading,
    Function onEditingComplete,
    String keyValue) {
  return TextField(
      style: TextStyle(fontSize: 20),
      controller: controller,
      focusNode: focusNode,
      onChanged: (_email) => onChanged(),
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        errorText: errorText ? "Invalid email" : null,
      ),
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      textInputAction: TextInputAction.go,
      enabled: !isLoading,
      onEditingComplete: () => onEditingComplete(),
      key: Key(keyValue)
  );
}

///A textfield for a password input
TextField buildPasswordTextField(
    TextEditingController controller,
    FocusNode focusNode,
    Function onChanged,
    String labelText,
    String hintText,
    bool errorText,
    bool isLoading,
    TextInputAction textInputAction,
    Function onEditingComplete,
    String keyValue) {
  return TextField(
      style: TextStyle(fontSize: 20),
      controller: controller,
      focusNode: focusNode,
      onChanged: (_password) => onChanged(),
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        errorText: errorText ? "4-20 chars, uppercase, lowercase, digits" : null,
      ),
      enabled: !isLoading,
      autocorrect: false,
      textInputAction: textInputAction,
      onEditingComplete: () => onEditingComplete(),
      obscureText: true,
      key: Key(keyValue)
  );
}

///A textfield for a confirm password input
TextField buildConfirmPasswordTextField(
    TextEditingController controller,
    FocusNode focusNode,
    Function onChanged,
    String labelText,
    String hintText,
    bool errorText,
    bool isLoading,
    TextInputAction textInputAction,
    Function submit,
    String keyValue) {
  return TextField(
      style: TextStyle(fontSize: 20),
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        errorText: errorText ? "passwords do not match" : null,
      ),
      enabled: !isLoading,
      autocorrect: false,
      textInputAction: textInputAction,
      onEditingComplete: () => submit(),
      obscureText: true,
      key: Key(keyValue)
  );
}