
import 'package:flutter/material.dart';

TextField buildUsernameTextField(
    TextEditingController controller,
    FocusNode focusNode,
    Function onChanged,
    bool errorText,
    bool isLoading,
    Function onEditingComplete) {

  return TextField(
      style: TextStyle(fontSize: 20),
      controller: controller,
      focusNode: focusNode,
      onChanged: (username) => onChanged(),
      decoration: InputDecoration(
        labelText: "Username",
        hintText: "Your username",
        errorText: errorText ? "Invalid username" : null,
      ),
      enabled: !isLoading,
      autocorrect: false,
      textInputAction: TextInputAction.go,
      onEditingComplete: () => onEditingComplete(),
      key: const Key("username_input")
  );
}

TextField buildEmailTextField(
    TextEditingController controller,
    FocusNode focusNode,
    Function onChanged,
    bool errorText,
    bool isLoading,
    Function onEditingComplete) {

  return TextField(
      style: TextStyle(fontSize: 20),
      controller: controller,
      focusNode: focusNode,
      onChanged: (_email) => onChanged(),
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Your Email Address",
        errorText: errorText ? "Invalid email" : null,
      ),
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      textInputAction: TextInputAction.go,
      enabled: !isLoading,
      onEditingComplete: () => onEditingComplete(),
      key: const Key("email_input")
  );
}

TextField buildPasswordTextField(
    TextEditingController controller,
    FocusNode focusNode,
    Function onChanged,
    bool errorText,
    bool isLoading,
    TextInputAction textInputAction,
    Function onEditingComplete) {
  return TextField(
      style: TextStyle(fontSize: 20),
      controller: controller,
      focusNode: focusNode,
      onChanged: (_password) => onChanged(),
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Your Password",
        errorText: errorText ? "4-20 chars, uppercase, lowercase, digits" : null,
      ),
      enabled: !isLoading,
      autocorrect: false,
      textInputAction: textInputAction,
      onEditingComplete: () => onEditingComplete(),
      obscureText: true,
      key: const Key("password_input")
  );
}

TextField buildConfirmPasswordTextField(
    TextEditingController controller,
    FocusNode focusNode,
    Function onChanged,
    bool errorText,
    bool isLoading,
    TextInputAction textInputAction,
    Function submit) {
  return TextField(
      style: TextStyle(fontSize: 20),
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
        labelText: "Confirm Password",
        hintText: "Rewrite your password",
        errorText: errorText ? "passwords do not match" : null,
      ),
      enabled: !isLoading,
      autocorrect: false,
      textInputAction: textInputAction,
      onEditingComplete: () => submit(),
      obscureText: true,
      key: const Key("confirmPassword_input")
  );
}