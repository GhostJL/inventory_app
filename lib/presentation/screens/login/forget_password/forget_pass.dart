import 'package:flutter/material.dart';
import 'package:inventory_app/presentation/screens/screen.dart';
import 'package:inventory_app/services/bd.dart';
import 'package:inventory_app/services/controllers_manager.dart';
import 'package:inventory_app/services/session_manager.dart';

class ForgetPass extends StatefulWidget {
  final String dataToSave;
  const ForgetPass({Key? key, required this.dataToSave}) : super(key: key);

  @override
  _ForgetPassState createState() => _ForgetPassState();
}

class _ForgetPassState extends State<ForgetPass> {
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

  @override
  Widget build(BuildContext context) {
    final dataToSave = widget.dataToSave;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: Text("Olvide mi contraseña"),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(32),
              child: Column(
                children: [
                  TextFormField(
                    enabled: false,
                    initialValue: dataToSave,
                    decoration: InputDecoration(
                        filled: true, labelText: "Ingrese su nombre"),
                  ),
                  SizedBox(height: 40),
                  TextFormField(
                    controller: controllerManager.passwordController,
                    decoration: InputDecoration(
                        filled: true, labelText: "Nueva contraseña"),
                  ),
                  SizedBox(height: 64),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2.4,
                        child: ElevatedButton(
                          onPressed: () async {
                            final updated = await db.updatePassword(dataToSave,
                                controllerManager.passwordController.text);
                            final isLoginSuccessful =
                                await verificarCredenciales(dataToSave,
                                    controllerManager.passwordController.text);
                            if (isLoginSuccessful) {
                              SessionManager().setLoggedIn(true);
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Nav()),
                                (route) => false,
                              );
                            }
                          },
                          child: Text("Actualizar"),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.white), // Fondo blanco
                            foregroundColor: MaterialStateProperty.all(
                                Color(0xFF1C1B1F)), // Texto en color "#1C1B1F"
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
