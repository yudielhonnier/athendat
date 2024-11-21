import 'package:athendat/core/error/failure.dart';
import 'package:athendat/core/resources/params/togg;e_products_params.dart';
import 'package:athendat/core/usecases/usecase.dart';
import 'package:fpdart/fpdart.dart';

import '../repository/product_repository.dart';

class ToggleProductApprovalUseCase
    implements Usecase<int, ToggleProductParams> {
  final ProductRepository productRepository;

  ToggleProductApprovalUseCase(this.productRepository);

  @override
  Future<Either<Failure, int>> call(ToggleProductParams params) =>
      productRepository.toggleProductApproval(
          params.product, params.isApproved);
}
