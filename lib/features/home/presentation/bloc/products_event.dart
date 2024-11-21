part of 'products_bloc.dart';

@immutable
sealed class ProductsEvent {}

class GetPendingProductsEvent extends ProductsEvent {
  final int page;
  final int limit;

  GetPendingProductsEvent({required this.page, required this.limit});
}

class GetCheckedProductsEvent extends ProductsEvent {
  final int pageChecked;
  final int limit;
  final List<ProductModel> products;

  GetCheckedProductsEvent({
    required this.pageChecked,
    required this.limit,
    required this.products,
  });
}

class UpdateProductEvent extends ProductsEvent {
  final Product product;
  final int page;

  UpdateProductEvent({
    required this.product,
    this.page = 1,
  });
}

class ToggleProductApprovalEvent extends ProductsEvent {
  final ProductModel product;
  final List<ProductModel> products;
  final bool isApproved;

  ToggleProductApprovalEvent(
    this.products, {
    required this.product,
    required this.isApproved,
  });
}

class DeleteProductEvent extends ProductsEvent {
  final String uuid;
  final List<ProductModel> products;

  DeleteProductEvent({required this.products, required this.uuid});
}
