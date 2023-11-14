import 'package:flutter/material.dart';
import 'package:inventory_app/presentation/screens/screen.dart';
import 'package:inventory_app/presentation/widgets/widgets.dart';
import 'package:inventory_app/services/bd.dart';
import 'package:inventory_app/services/maps/maps.dart';

class Categorias extends StatefulWidget {
  const Categorias({Key? key}) : super(key: key);

  @override
  _CategoriasState createState() => _CategoriasState();
}

class _CategoriasState extends State<Categorias> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: MyData.instance.getAllItemsCat(),
        builder: (BuildContext context,
            AsyncSnapshot<List<CategoriesItem>> snaptshot) {
          var categoriesItems = snaptshot.data;
          if (snaptshot.hasData) {
            List<CategoriesItem> categoriesItems = snaptshot.data!;
            return categoriesItems.isEmpty
                ? Scaffold(
                    body: CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          leading: IconButton(
                              icon: const Icon(Icons.search_rounded),
                              onPressed: () {}),
                          centerTitle: true,
                          title: Text("Categorías"),
                          actions: <Widget>[
                            IconButton(
                              icon: const Icon(Icons.person_2_rounded),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Perfil()),
                                );
                              },
                            ),
                          ],
                        ),
                        SliverToBoxAdapter(
                          child: Container(
                            alignment: Alignment.center,
                            height: MediaQuery.of(context).size.height,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.category,
                                  size: 48,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  "No hay categorías por mostrar",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 16),
                                ),
                                SizedBox(
                                  height: 180,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    floatingActionButton: FloatingActionButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddCategoria()),
                        );
                      },
                      child: Icon(
                        Icons.add_outlined,
                        color: Colors.black,
                      ),
                    ),
                  )
                : Scaffold(
                    body: CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          leading: IconButton(
                              icon: const Icon(Icons.search_rounded),
                              onPressed: () {}),
                          centerTitle: true,
                          title: Text("Categorías"),
                          actions: <Widget>[
                            IconButton(
                              icon: const Icon(Icons.person_2_rounded),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Perfil()),
                                );
                              },
                            ),
                          ],
                        ),
                        SliverGrid(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0,
                            childAspectRatio: 1.8,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return _CategoriesItem(categoriesItems[index]);
                            },
                            childCount: categoriesItems.length,
                          ),
                        ),
                      ],
                    ),
                    floatingActionButton: FloatingActionButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddCategoria()),
                        );
                      },
                      child: Icon(
                        Icons.add_outlined,
                        color: Colors.black,
                      ),
                    ),
                  );
          } else {
            return Scaffold(
              body: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    leading: IconButton(
                        icon: const Icon(Icons.search_rounded),
                        onPressed: () {}),
                    centerTitle: true,
                    title: Text("Categorías"),
                    actions: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.person_2_rounded),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Perfil()),
                          );
                        },
                      ),
                    ],
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.category,
                            size: 48,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            "No hay categorías por mostrar",
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                          SizedBox(
                            height: 180,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddCategoria()),
                  );
                },
                child: Icon(
                  Icons.add_outlined,
                  color: Colors.black,
                ),
              ),
            );
          }
        });
  }
}

class _CategoriesItem extends StatelessWidget {
  final CategoriesItem categoriesItem;

  const _CategoriesItem(this.categoriesItem);

  @override
  Widget build(BuildContext context) {
    return CustomCardCategoria(
      nombre: categoriesItem.name,
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Categorizacion()),
      ),
      //Agregado
      onLongPress: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ViewCategorias()),
      ),
    );
  }
}
