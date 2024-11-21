import 'package:athendat/features/home/data/models/product_model.dart';

class ToggleProductParams {
  final ProductModel product;
  final bool isApproved;

  ToggleProductParams({required this.product, required this.isApproved});
}
