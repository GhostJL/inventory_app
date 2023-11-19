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
                            icon: Icon(Icons.search),
                            onPressed: () {
                              showSearch(
                                  context: context,
                                  delegate:
                                      SearchDelegateCategory(categoriesItems));
                            },
                          ),
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
                            icon: Icon(Icons.search),
                            onPressed: () {
                              showSearch(
                                  context: context,
                                  delegate:
                                      SearchDelegateCategory(categoriesItems));
                            },
                          ),
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
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  '¡Ups!',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors
                                        .red, // Color rojo para resaltar el mensaje de error
                                  ),
                                ),
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'No se encontraron categorías.',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text('OK'),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors
                                          .blue, // Color azul para el botón OK
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }),
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
        MaterialPageRoute(
          builder: (context) => Categorizacion(
            nameCategoria: categoriesItem.name,
          ),
        ),
      ),
      //Agregado
      onLongPress: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ViewCategorias(
            nameCategoria: categoriesItem.name,
          ),
        ),
      ),
    );
  }
}

class SearchDelegateCategory extends SearchDelegate<String> {
  final List<CategoriesItem> categoryList;

  SearchDelegateCategory(this.categoryList);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final filteredCategories = categoryList.where((category) =>
        category.name.toLowerCase().contains(query.toLowerCase()));

    return CustomScrollView(
      slivers: [
        SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 1.8,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              final category = filteredCategories.elementAt(index);
              return _CategoriesItem(category);
            },
            childCount: filteredCategories.length,
          ),
        ),
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = categoryList
        .where((category) =>
            category.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        final suggestion = suggestionList[index];
        return ListTile(
          title: Text(suggestion.name),
          onTap: () {
            query = suggestion.name;

            showResults(context);
          },
        );
      },
    );
  }
}
