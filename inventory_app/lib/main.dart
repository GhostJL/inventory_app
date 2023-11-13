import 'package:flutter/material.dart';
import 'package:inventory_app/presentation/app.dart';
import 'package:inventory_app/services/bd.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'services/session_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharedPreferences.getInstance();
  await MyData.instance.database;
  final sessionManager = SessionManager();
  final isLoggedIn = await sessionManager.isLoggedIn();
  runApp(MainApp(isLoggedIn: isLoggedIn));
}
