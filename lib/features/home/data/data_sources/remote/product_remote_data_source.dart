import 'package:athendat/features/home/data/models/product_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'product_remote_data_source.g.dart';

abstract class ProductRemoteDataSource {
  ///Calls the http://[base_url] endpoint
  ///
  ///Throws a [ServerException] for all the error codes
  Future<List<ProductModel>> getProducts(int page, int limit);
}

@RestApi(
    baseUrl: 'https://jsonplaceholder.typicode.com/posts?_limit=10&&_page=0')
abstract class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  factory ProductRemoteDataSourceImpl(Dio dio, {String baseUrl}) =
      _ProductRemoteDataSourceImpl;

  @GET('/posts')
  @override
  Future<List<ProductModel>> getProducts(
    @Query("_page") int page,
    @Query("_limit") int limit,
  );
}
