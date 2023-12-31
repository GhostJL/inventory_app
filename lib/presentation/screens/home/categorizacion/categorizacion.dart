import 'package:flutter/material.dart';
import 'package:inventory_app/presentation/screens/screen.dart';
import 'package:inventory_app/presentation/widgets/widgets.dart';
import 'package:inventory_app/services/bd.dart';
import 'package:inventory_app/services/maps/maps.dart';

class Categorizacion extends StatefulWidget {
  final String nameCategoria;
  const Categorizacion({Key? key, required this.nameCategoria})
      : super(key: key);

  @override
  _CategorizacionState createState() => _CategorizacionState();
}

class _CategorizacionState extends State<Categorizacion> {
  int? categoryId = 0;

  @override
  void initState() {
    super.initState();
    obtenerCategoryId();
  }

  void obtenerCategoryId() {
    final name = widget.nameCategoria;

    MyData.instance.getCategoryIdByName(name).then((int? id) {
      setState(() {
        categoryId = id;
      });
      print(categoryId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final name = widget.nameCategoria;
    print(categoryId);

    return FutureBuilder(
      future: MyData.instance.getAllItemsProdsForCat(categoryId!),
      builder:
          (BuildContext context, AsyncSnapshot<List<ProductsItems>> snapshot) {
        var productsItems = snapshot.data;
        if (snapshot.hasData) {
          List<ProductsItems> productsItems = snapshot.data!;
          return productsItems.isEmpty
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
                                    SearchDelegateProductsCat(productsItems));
                          },
                        ),
                        centerTitle: true,
                        title: Text("Productos"),
                        actions: [
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
                        child: Center(
                          child: Text(
                            name,
                            style: TextStyle(
                              color: Color(0xFF9198AB),
                            ),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Container(
                          alignment: Alignment.center,
                          height: MediaQuery.of(context).size.height,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.shopping_bag,
                                size: 48,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Text(
                                "No hay productos por mostrar.",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 16),
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
                        MaterialPageRoute(builder: (context) => AddProducto()),
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
                                    SearchDelegateProductsCat(productsItems));
                          },
                        ),
                        centerTitle: true,
                        title: Text("Productos"),
                        actions: [
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
                        child: Center(
                          child: Text(
                            name,
                            style: TextStyle(
                              color: Color(0xFF9198AB),
                            ),
                          ),
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return _ProductsItems(productsItems[index]);
                          },
                          childCount: productsItems.length,
                        ),
                      ),
                    ],
                  ),
                  floatingActionButton: FloatingActionButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddProducto()),
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
                      icon: const Icon(Icons.search_rounded), onPressed: () {}),
                  centerTitle: true,
                  title: Text("Productos"),
                  actions: [
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
                          Icons.shopping_bag,
                          size: 48,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          "No hay productos por mostrar",
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
                  MaterialPageRoute(builder: (context) => AddProducto()),
                );
              },
              child: Icon(
                Icons.add_outlined,
                color: Colors.black,
              ),
            ),
          );
        }
      },
    );
  }
}

class _ProductsItems extends StatelessWidget {
  final ProductsItems productsItems;

  const _ProductsItems(this.productsItems);
  @override
  Widget build(BuildContext context) {
    return CustomCardProducto(
      nombre: productsItems.name,
      cantidad: productsItems.quantity.toString(),
      precio: productsItems.price,
      direccionImagen: productsItems.image,
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ViewProductos(
            image: productsItems.image,
            serialNumber: productsItems.serialNumber,
            category: productsItems.category_id.toString(),
            name: productsItems.name,
            quantity: productsItems.quantity,
            price: productsItems.price,
          ),
        ),
      ),
    );
  }
}

class SearchDelegateProductsCat extends SearchDelegate<String> {
  final List<ProductsItems> productsList;

  SearchDelegateProductsCat(this.productsList);

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
    final filteredProducts = productsList.where(
        (product) => product.name.toLowerCase().contains(query.toLowerCase()));

    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              final product = filteredProducts.elementAt(index);
              return _ProductsItems(product);
            },
            childCount: filteredProducts.length,
          ),
        ),
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = productsList
        .where((product) =>
            product.name.toLowerCase().contains(query.toLowerCase()))
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
