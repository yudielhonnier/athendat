import 'package:athendat/core/helpers/extensions.dart';
import 'package:athendat/features/home/data/models/product_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';

class ProductDatabaseHelper {
  static final ProductDatabaseHelper _instance =
      ProductDatabaseHelper.internal();
  factory ProductDatabaseHelper() => _instance;

  static Database? _database;

  ProductDatabaseHelper.internal();

  // Define the table name and column names
  final String tableProducts = 'products3';
  String columnId = 'id';
  String columnUuid = 'uuid';
  String columnTitle = 'title';
  String columnBody = 'body';
  String columnApproved = 'approved';

  Future<Database> get database async {
    _database = await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = p.join(databasesPath, 'product2.db');

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: _createDb,
    );
  }

  void _createDb(Database db, int version) async {
    await db.execute('''
  CREATE TABLE $tableProducts (
    $columnUuid String PRIMARY KEY,
    $columnId INTEGER ,
    $columnTitle TEXT,
    $columnBody TEXT,
    $columnApproved INTEGER
  )
  ''');
  }

  // CRUD functions
  Future<bool> isPresent(Database db, ProductModel product) async {
    final item = await db.query(
      tableProducts,
      where: 'id  = ? AND title = ?',
      whereArgs: [product.id, product.title],
    );

    return item.isNotEmpty;
  }

  Future<int> upsertProduct(ProductModel product) async {
    final db = await database;

    final alreadyExist = await isPresent(db, product);

    if (product.uuid.isNullOrEmpty && !alreadyExist) {
      final toSave = product.copyWith(uuid: const Uuid().v4());
      final toSaveJson = toSave.toJson();
      final res = await db.insert(tableProducts, toSaveJson);
      return res;
    } else {
      final res = await db.update(
        tableProducts,
        product.toJson(),
        where: 'uuid = ?',
        whereArgs: [product.uuid],
      );

      return res;
    }
  }

  Future<ProductModel> getProduct(String uuid) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableProducts,
      where: '$columnUuid = ?',
      whereArgs: [uuid],
    );

    if (maps.isNotEmpty) {
      return ProductModel.fromJson(maps.first);
    }

    return ProductModel.productMockEmpty;
  }

  Future<List<ProductModel>> getAllProducts(
      {int page = 1, int limit = 7}) async {
    final db = await database;
    final offset = (page - 1) * limit;

    final List<Map<String, dynamic>> maps = await db.query(
      tableProducts,
      limit: limit,
      offset: offset,
      orderBy: 'uuid ASC', // Adjust the ordering as needed
    );

    return List.generate(maps.length, (i) {
      return ProductModel.fromJson(maps[i]);
    });
  }

  Future<void> updateProduct(ProductModel product) async {
    final db = await database;
    await db.update(
      tableProducts,
      product.toJson(),
      where: '$columnUuid = ?',
      whereArgs: [product.uuid],
    );
  }

  Future<int> deleteProduct(String uuid) async {
    final db = await database;

    final deletedId = await db.delete(
      tableProducts,
      where: '$columnUuid = ?',
      whereArgs: [uuid],
    );

    return deletedId;
  }
}
