import 'package:flutter/material.dart';

class ControllerManager {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController categorieController = TextEditingController();
  final TextEditingController codeController = TextEditingController();

  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    categorieController.dispose();
    codeController.dispose();
  }
}
