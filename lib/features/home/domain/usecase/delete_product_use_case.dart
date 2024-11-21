import 'package:athendat/core/error/failure.dart';
import 'package:athendat/core/resources/params/togg;e_products_params.dart';
import 'package:athendat/core/usecases/usecase.dart';
import 'package:fpdart/fpdart.dart';

import '../repository/product_repository.dart';

class DeleteProductUseCase implements Usecase<int, String> {
  final ProductRepository productRepository;

  DeleteProductUseCase(this.productRepository);

  @override
  Future<Either<Failure, int>> call(uuid) =>
      productRepository.deleteProduct(uuid);
}
