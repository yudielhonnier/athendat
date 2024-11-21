import 'package:athendat/core/error/failure.dart';
import 'package:athendat/features/home/domain/entities/product.dart';

import 'package:fpdart/fpdart.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getPendingProducts(
      int page, int limit);

  Future<Either<Failure, List<Product>>> getCheckedProducts(
      int page, int limit);

  Future<Either<Failure, int>> toggleProductApproval(
      Product product, bool isApproved);

  Future<Either<Failure, int>> deleteProduct(String uuid);
}
