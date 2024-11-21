import 'dart:convert';

import 'package:athendat/core/constants/constants.dart';
import 'package:athendat/core/error/exceptions.dart';
import 'package:athendat/core/resources/product_db_helper.dart';
import 'package:athendat/features/home/data/models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ProductLocalDataSource {
  ///Gets the cached [ProductModel] list wich was gotten the last time
  ///the user had an internet connection
  ///
  ///Throws a [CachedException] if no cached data is present.
  Future<List<ProductModel>> getLastProducts();

  ///Gets the  [ProductModel] from the local db
  ///
  ///Throws a [CachedException] if no cached data is present.
  Future<List<ProductModel>> getCheckedProducts(int page, int limit);

  Future<void> cacheProducts(List<ProductModel> products);

  Future<int> toggleProductApproval(ProductModel product, bool isApprovad);
  Future<int> deleteProduct(String uuid);
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final SharedPreferences sharedPreferences;
  final ProductDatabaseHelper productDB;

  ProductLocalDataSourceImpl(
      {required this.sharedPreferences, required this.productDB});

  @override
  Future<void> cacheProducts(List<ProductModel> products) async {
    final productsString = <String>[];

    for (var product in products) {
      productsString.add(json.encode(product.toJson()));
    }

    await sharedPreferences.setStringList(cachedProducts, productsString);
  }

  @override
  Future<List<ProductModel>> getLastProducts() async {
    final cachedProductsString =
        sharedPreferences.getStringList(cachedProducts);

    final lastCachedUsers = <ProductModel>[];

    if (cachedProductsString != null) {
      for (var Product in cachedProductsString) {
        lastCachedUsers.add(ProductModel.fromJson(json.decode(Product)));
      }

      return lastCachedUsers;
    } else {
      throw CacheException();
    }
  }

  @override
  Future<List<ProductModel>> getCheckedProducts(int page, int limit) {
    return productDB.getAllProducts(page: page, limit: limit);
  }

  @override
  Future<int> toggleProductApproval(ProductModel product, bool isApprovad) {
    final toToggle = product.copyWith(approved: isApprovad ? 1 : 0);
    return productDB.upsertProduct(toToggle);
  }

  @override
  Future<int> deleteProduct(String uuid) {
    return productDB.deleteProduct(uuid);
  }
}
