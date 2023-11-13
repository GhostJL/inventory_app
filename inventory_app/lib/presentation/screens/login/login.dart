import 'package:flutter/material.dart';
import 'package:inventory_app/presentation/screens/screen.dart';
import 'package:inventory_app/services/bd.dart';
import 'package:inventory_app/services/controllers_manager.dart';
import 'package:inventory_app/services/session_manager.dart';
import 'package:sqflite/sqflite.dart';

class Login extends StatefulWidget {
  static String routerName = '/login';

  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final controllerManager = ControllerManager();
  late final MyData db;

  @override
  void initState() {
    super.initState();
    db = MyData.instance;
  }

  Future<bool> verificarCredenciales(String username, String password) async {
    return await db.verifyUserCredentials(username, password);
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      final username = controllerManager.usernameController.text;
      final password = controllerManager.passwordController.text;

      final isLoginSuccessful = await verificarCredenciales(username, password);

      if (isLoginSuccessful) {
        SessionManager().setLoggedIn(true);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => Nav()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            content: Text('Usuario o contraseña incorrectos'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool _obscureText = true;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(32, 0, 32, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(padding: EdgeInsets.all(48)),
            Row(
              children: const [
                Text(
                  "Login",
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                )
              ],
            ),
            Row(
              children: const [
                Text(
                  "Bienvenido, ingresa a tu cuenta.",
                  style: TextStyle(
                      fontWeight: FontWeight.w200,
                      fontSize: 16,
                      color: Colors.grey),
                )
              ],
            ),
            SizedBox(height: 80),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controllerManager.usernameController,
                    textInputAction: TextInputAction.next,
                    decoration:
                        InputDecoration(filled: true, labelText: "Usuario"),
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    controller: controllerManager.passwordController,
                    decoration:
                        InputDecoration(filled: true, labelText: "Contraseña"),
                  ),
                ],
              ),
            ),
            SizedBox(height: 60),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _login,
                child: Text("Iniciar sesión"),
              ),
            ),
            SizedBox(height: 70),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ForgetPassName()),
                );
              },
              child: Text(
                "¿Olvidaste tu contraseña?",
                style: TextStyle(color: Color(0xFF9198AB)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
