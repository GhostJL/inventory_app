import 'package:inventory_app/presentation/screens/home/categorias.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'maps/maps.dart';

class MyData {
  static final MyData instance = MyData._init();

  static Database? _database;

  MyData._init();

  final String tableUser = 'users';
  final String tableProducts = 'products';
  final String tableCategories = 'categories';

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('my_databse.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _onCreateDB);
  }

  Future _onCreateDB(Database db, int version) async {
    await db.execute(
        '''
          CREATE TABLE $tableUser (
            id INTEGER PRIMARY KEY,
            username TEXT,
            password TEXT
          )
        ''');
    final count = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $tableUser'));
    if (count == 0) {
      await db.insert('$tableUser', {
        'username': 'admin',
        'password': 'admin',
      });
    }
    await db.execute(
        '''
          CREATE TABLE $tableProducts (
            id INTEGER PRIMARY KEY,
            image TEXT,
            serialNumber TEXT,
            name TEXT,
            category_id INTEGER,  -- Cambiado a un campo de tipo INTEGER
            quantity INTEGER,
            price REAL,
            FOREIGN KEY (category_id) REFERENCES $tableCategories(id)  -- Clave foránea
          )
        ''');

    await db.execute(
        '''
          CREATE TABLE $tableCategories (
            id INTEGER PRIMARY KEY,
            name TEXT
          )
        ''');
  }

  //Insertar datos
  Future<void> insertUser(UserItem item) async {
    final db = await instance.database;
    await db.insert(tableUser, item.toMap());
  }

  Future<void> insertCategorie(CategoriesItem item) async {
    final db = await instance.database;
    await db.insert(tableCategories, item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> insertProducts(ProductsItems item) async {
    final db = await instance.database;
    await db.insert(tableProducts, item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  //Consultar datos
  Future<bool> verifyUserCredentials(String username, String password) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> result = await db.rawQuery(
      "SELECT * FROM $tableUser WHERE username = ? AND password = ?",
      [username, password],
    );

    return result.isNotEmpty;
  }

  Future<bool> verifyUser(String username) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> result = await db.rawQuery(
      "SELECT * FROM $tableUser WHERE username = ?",
      [username],
    );

    return result.isNotEmpty;
  }

  Future<bool?> verifyCategoryProducts(int id) async {
    final db = await instance.database;

    List<Map<String, dynamic>> result = await db.query(
      tableProducts,
      columns: ['category_id'],
      where: 'category_id = ?',
      whereArgs: [id],
    );
    return result.isNotEmpty;
  }

  Future<String> getUserName() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> result = await db.query(
      tableUser,
      columns: ['username'],
    );

    return result.first['username'] as String;
  }

  Future<List<CategoriesItem>> getAllItemsCat() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(tableCategories);

    return List.generate(maps.length, (i) {
      return CategoriesItem(name: maps[i]['name']);
    });
  }

  Future<List<ProductsItems>> getAllItemsProds() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(tableProducts);

    return List.generate(maps.length, (i) {
      return ProductsItems(
          image: maps[i]['image'],
          serialNumber: maps[i]['serialNumber'],
          category_id: maps[i]['category_id'],
          name: maps[i]['name'],
          quantity: maps[i]['quantity'],
          price: maps[i]['price']);
    });
  }

  //El nombre devuelve un id
  Future<int?> getProductIdByName(String productName) async {
    final Database db = await instance.database;

    List<Map<String, dynamic>> result = await db.query(
      tableProducts,
      columns: ['id'],
      where: 'name = ?',
      whereArgs: [productName],
    );

    return result.first['id'];
  }

  //El nombre devuelve un id
  Future<int?> getCategoryIdByName(String categoryName) async {
    final Database db = await instance.database;

    List<Map<String, dynamic>> result = await db.query(
      tableCategories,
      columns: ['id'],
      where: 'name = ?',
      whereArgs: [categoryName],
    );

    return result.first['id'];
  }

  //El id devuelve el nombre
  Future<String?> getCategoryNameById(String category_id) async {
    final Database db = await instance.database;

    List<Map<String, dynamic>> result = await db.query(
      tableCategories,
      columns: ['name'],
      where: 'id = ?',
      whereArgs: [category_id],
    );
    return result.first['name'];
  }

  Future<String?> getCategoryName(int categoryId) async {
    final Database db = await instance.database;

    List<Map<String, dynamic>> result = await db.query(
      tableCategories,
      columns: ['name'],
      where: 'id = ?',
      whereArgs: [categoryId],
    );

    if (result.isNotEmpty) {
      return result.first['name'];
    } else {
      return null; // O 'Sin categoría' si prefieres un valor predeterminado
    }
  }

  Future<List<ProductsItems>> getAllItemsProdsForCat(int category_id) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableProducts,
      where: 'category_id = ?',
      whereArgs: [category_id],
    );

    return List.generate(maps.length, (i) {
      return ProductsItems(
          image: maps[i]['image'],
          serialNumber: maps[i]['serialNumber'],
          category_id: maps[i]['category_id'],
          name: maps[i]['name'],
          quantity: maps[i]['quantity'],
          price: maps[i]['price']);
    });
  }

  //Actualizar datos
  Future<int> updateProfile(String username, String newPassword) async {
    final db = await instance.database;
    return await db.update(
      tableUser,
      {'username': username, 'password': newPassword},
    );
  }

  Future<int> updatePassword(String username, String newPassword) async {
    final db = await instance.database;

    return await db.update(
      tableUser,
      {'password': newPassword},
      where: 'username = ?',
      whereArgs: [username],
    );
  }

  Future<int> updateCategory(int oldCategory, String newCategory) async {
    final db = await instance.database;
    return await db.update(
      tableCategories,
      {'name': newCategory},
      where: 'id = ?',
      whereArgs: [oldCategory],
    );
  }

  Future<void> updateProductWithId(
      String serialNumber, ProductsItems updatedProduct) async {
    final db = await instance.database;
    await db.update(
      tableProducts,
      updatedProduct.toMap(),
      where: 'serialNumber = ?',
      whereArgs: [serialNumber],
    );
  }

  //Eliminaciones
  Future<int?> deleteCategory(int id) async {
    final db = await instance.database;
    return await db.delete(
      tableCategories,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<int?> deleteProducts(int id) async {
    final db = await instance.database;
    return await db.delete(
      tableProducts,
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
