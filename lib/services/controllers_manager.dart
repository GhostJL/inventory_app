import 'package:flutter/material.dart';

class ControllerManager {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController categorieController = TextEditingController();

  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    categorieController.dispose();
  }
}
