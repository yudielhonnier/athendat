import 'package:athendat/core/error/exceptions.dart';
import 'package:athendat/core/error/failure.dart';
import 'package:athendat/core/network/network_info.dart';
import 'package:athendat/features/home/data/data_sources/local/product_local_data_source.dart';
import 'package:athendat/features/home/data/data_sources/remote/product_remote_data_source.dart';
import 'package:athendat/features/home/data/models/product_model.dart';
import 'package:athendat/features/home/domain/entities/product.dart';
import 'package:athendat/features/home/domain/repository/product_repository.dart';
import 'package:fpdart/fpdart.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<ProductModel>>> getPendingProducts(
      page, limit) async {
    bool isConnected = await networkInfo.isConnected;

    if (isConnected) {
      try {
        final remote = await remoteDataSource.getProducts(page, limit);
        localDataSource.cacheProducts(remote);
        return Right(remote);
      } on ServerException catch (e) {
        return Left(ApiRequestError(error: e));
      }
    } else {
      try {
        final localProducts = await localDataSource.getLastProducts();
        Right(localProducts);
      } on CacheException catch (e) {
        return Left(DbCachingError(error: e));
      }
    }
    return Left(UnknowFailure());
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getCheckedProducts(
      page, limit) async {
    try {
      final localProducts =
          await localDataSource.getCheckedProducts(page, limit);
      return Right(localProducts);
    } on CacheException catch (e) {
      return Left(DbCachingError(error: e));
    }
  }

  @override
  Future<Either<Failure, int>> toggleProductApproval(
      Product product, bool isApproved) async {
    try {
      final toggledProduct = await localDataSource.toggleProductApproval(
          product as ProductModel, isApproved);
      return Right(toggledProduct);
    } on CacheException catch (e) {
      return Left(DbError(error: e));
    }
  }

  @override
  Future<Either<Failure, int>> deleteProduct(String uuid) async {
    try {
      final deletedProduct = await localDataSource.deleteProduct(uuid);
      return Right(deletedProduct);
    } on CacheException catch (e) {
      return Left(DbError(error: e));
    }
  }
}
