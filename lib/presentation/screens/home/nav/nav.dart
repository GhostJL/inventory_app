import 'package:flutter/material.dart';
import 'package:inventory_app/presentation/screens/screen.dart';

class Nav extends StatefulWidget {
  static String routerName = '/nav';
  const Nav({Key? key}) : super(key: key);

  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        surfaceTintColor: Colors.white,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.shopping_bag_rounded),
            icon: Icon(Icons.shopping_bag_outlined),
            label: 'Productos',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.notes_rounded),
            icon: Icon(Icons.notes_outlined),
            label: 'Categorías',
          ),
        ],
      ),
      body: <Widget>[
        Container(
          child: Productos(),
        ),
        Container(
          child: Categorias(),
        ),
      ][currentPageIndex],
    );
  }
}
