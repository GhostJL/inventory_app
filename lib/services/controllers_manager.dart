import 'package:flutter/material.dart';

class ControllerManager {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController categorieController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController imagePController = TextEditingController();
  final TextEditingController numSeriePController = TextEditingController();
  final TextEditingController categoriePController = TextEditingController();
  final TextEditingController namePController = TextEditingController();
  final TextEditingController cantidadPController = TextEditingController();
  final TextEditingController pricePController = TextEditingController();

  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    categorieController.dispose();
    codeController.dispose();
    imagePController.dispose();
    numSeriePController.dispose();
    categoriePController.dispose();
    namePController.dispose();
    cantidadPController.dispose();
    pricePController.dispose();
  }
}
