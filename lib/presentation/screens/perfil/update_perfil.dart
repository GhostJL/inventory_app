import 'package:flutter/material.dart';
import 'package:inventory_app/presentation/screens/screen.dart';
import 'package:inventory_app/services/bd.dart';
import 'package:inventory_app/services/controllers_manager.dart';

class UpdatePerfil extends StatefulWidget {
  final String userName;
  const UpdatePerfil({Key? key, required this.userName}) : super(key: key);

  @override
  _UpdatePerfilState createState() => _UpdatePerfilState();
}

class _UpdatePerfilState extends State<UpdatePerfil> {
  final controllerManager = ControllerManager();
  late MyData db;

  @override
  void initState() {
    super.initState();
    db = MyData.instance;
  }

  Future<void> updateProfile() async {
    final newPassword = controllerManager.passwordController.text;
    final newName = controllerManager.usernameController.text;

    if (newPassword.isNotEmpty && newName.isNotEmpty) {
      await db.updateProfile(newName, newPassword);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          content: Row(
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
              SizedBox(width: 8.0),
              Text('Perfil actualizado con éxito.'),
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
      );
      Navigator.popUntil(context, (route) => route.isFirst);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          content: Row(
            children: [
              Icon(
                Icons.warning,
                color: Colors.orange,
              ),
              SizedBox(width: 8.0),
              Text('Por favor, verifique los campos.'),
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.userName;
    controllerManager.usernameController.text = user;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: Text("Cuenta"),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(32),
              child: Column(
                children: [
                  TextFormField(
                    controller: controllerManager.usernameController,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      filled: true,
                      labelText: "Nombre",
                      hintText: "Nuevo nombre",
                    ),
                  ),
                  TextFormField(
                    controller: controllerManager.passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                        filled: true,
                        labelText: "Contraseña",
                        hintText: "Nueva contraseña o actual"),
                  ),
                  SizedBox(height: 60),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        updateProfile();
                      },
                      child: Text("Actualizar"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
