import 'package:athendat/core/error/failure.dart';
import 'package:athendat/core/resources/params/get_products_params.dart';
import 'package:athendat/core/usecases/usecase.dart';
import 'package:athendat/features/home/domain/entities/product.dart';
import 'package:fpdart/fpdart.dart';

import '../repository/product_repository.dart';

class GetPendingProductsUseCase
    implements Usecase<List<Product>, GetProductsParams> {
  final ProductRepository productRepository;

  GetPendingProductsUseCase(this.productRepository);

  @override
  Future<Either<Failure, List<Product>>> call(GetProductsParams params) =>
      productRepository.getPendingProducts(params.page, params.limit);
}
