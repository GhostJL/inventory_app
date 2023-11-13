import 'package:flutter/material.dart';
import 'package:inventory_app/presentation/screens/screen.dart';
import 'package:inventory_app/services/bd.dart';
import 'package:inventory_app/services/controllers_manager.dart';

class ForgetPassName extends StatefulWidget {
  const ForgetPassName({Key? key}) : super(key: key);

  @override
  _ForgetPassNameState createState() => _ForgetPassNameState();
}

class _ForgetPassNameState extends State<ForgetPassName> {
  final controllerManager = ControllerManager();
  late final MyData db;

  @override
  void initState() {
    super.initState();
    db = MyData.instance;
  }

  Future<bool> verificarCredenciales(String username) async {
    return await db.verifyUser(username);
  }

  @override
  Widget build(BuildContext context) {
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
                    controller: controllerManager.usernameController,
                    decoration: InputDecoration(
                        filled: true, labelText: "Ingrese su nombre"),
                  ),
                  SizedBox(height: 64),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2.4,
                        child: ElevatedButton(
                          onPressed: () async {
                            final isLoginSuccessful =
                                await verificarCredenciales(
                                    controllerManager.usernameController.text);
                            if (isLoginSuccessful) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ForgetPass(
                                    dataToSave: controllerManager
                                        .usernameController.text,
                                  ),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  duration: Duration(seconds: 2),
                                  behavior: SnackBarBehavior.floating,
                                  content: Text('Usuario incorrecto'),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                              );
                            }
                          },
                          child: Text("Siguiente"),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            foregroundColor:
                                MaterialStateProperty.all(Color(0xFF1C1B1F)),
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
