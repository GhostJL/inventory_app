import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventory_app/presentation/screens/screen.dart';

class MainApp extends StatelessWidget {
  final bool isLoggedIn;
  const MainApp({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      title: "Aplicación Móvil para Inventarios",
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
          useMaterial3: true,
          textTheme: GoogleFonts.latoTextTheme(textTheme).copyWith(
            bodyMedium: GoogleFonts.inter(textStyle: textTheme.bodyMedium),
          ),
          colorSchemeSeed: Colors.blueGrey,
          brightness: Brightness.dark),
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.latoTextTheme(textTheme).copyWith(
          bodyMedium: GoogleFonts.inter(textStyle: textTheme.bodyMedium),
        ),
        colorScheme: ColorScheme.light(
          primary: Colors.white,
          secondary: Colors.grey.shade100,
          surface: Colors.white,
        ),
        brightness: Brightness.light,
        inputDecorationTheme: const InputDecorationTheme(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF3333FF)),
          ),
          labelStyle: TextStyle(
            color: Color(0xFF9198AB),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(const Color(0xFF3333FF)),
            foregroundColor: MaterialStateProperty.all(Colors.white),
          ),
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFF3333FF),
        ),
      ),
      initialRoute: isLoggedIn ? Nav.routerName : Login.routerName,
      routes: {
        Login.routerName: (_) => const Login(),
        Nav.routerName: (_) => const Nav(),
      },
    );
  }
}
