import 'package:flutter/material.dart';
import 'package:inventory_app/presentation/screens/screen.dart';
import 'package:inventory_app/presentation/widgets/widgets.dart';
import 'package:inventory_app/services/bd.dart';
import 'package:inventory_app/services/session_manager.dart';
import 'package:sqflite/sqflite.dart';

class Perfil extends StatefulWidget {
  const Perfil({Key? key}) : super(key: key);

  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  late final MyData db;
  late String userName = "";
  @override
  void initState() {
    super.initState();
    loadUserName();
  }

  Future<void> loadUserName() async {
    db = MyData.instance;
    final userNameFromDB = await db.getUserName();
    setState(() {
      userName = userNameFromDB;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: Text("Mi cuenta"),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Column(
                children: [
                  CardPerfil(
                    nombre: userName,
                    direccionImagen: 'assets/user.png',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                UpdatePerfil(userName: userName)),
                      );
                    },
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  buildMenuItem("Actualizar cuenta", Icons.edit, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdatePerfil(userName: userName),
                      ),
                    );
                  }),
                  buildMenuItem("Cerrar sesión", Icons.logout, () {
                    SessionManager().setLoggedIn(false);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const Login()),
                      (route) => false,
                    );
                  })
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildMenuItem(String title, IconData icon, VoidCallback onPressed) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
      ),
      onTap: onPressed,
    );
  }
}
