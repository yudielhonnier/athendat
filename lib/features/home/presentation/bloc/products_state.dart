part of 'products_bloc.dart';

@immutable
sealed class ProductsState {}

final class Empty extends ProductsState {
  final List<ProductModel> products;

  Empty(this.products);
}

final class Loading extends ProductsState {}

final class Loaded extends ProductsState {
  final List<ProductModel> products;

  final int pagePending;
  final int pageChecked;

  Loaded({required this.products, this.pagePending = 0, this.pageChecked = 1});
}

final class Error extends ProductsState {
  final String message;

  Error({required this.message});
}
