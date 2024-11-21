import 'package:athendat/core/constants/constants.dart';
import 'package:athendat/core/resources/params/get_products_params.dart';
import 'package:athendat/core/resources/params/togg;e_products_params.dart';
import 'package:athendat/features/home/data/models/product_model.dart';
import 'package:athendat/features/home/domain/entities/product.dart';
import 'package:athendat/features/home/domain/usecase/delete_product_use_case.dart';
import 'package:athendat/features/home/domain/usecase/get_checked_products_use_case.dart';
import 'package:athendat/features/home/domain/usecase/get_pending_products_use_case.dart';
import 'package:athendat/features/home/domain/usecase/toggle_product_approval_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

part 'products_event.dart';
part 'products_state.dart';

//todo: finish the pagination
class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final GetPendingProductsUseCase _getProductsPendingUseCase;
  final GetCheckedProductsUseCase _getCheckedProductsUseCase;
  final ToggleProductApprovalUseCase _toggleProductApprovalUseCase;
  final DeleteProductUseCase _deleteProductUseCase;

  ProductsBloc(this._getProductsPendingUseCase, this._getCheckedProductsUseCase,
      this._toggleProductApprovalUseCase, this._deleteProductUseCase)
      : super(Empty(const [])) {
    on<GetPendingProductsEvent>(onGetPendingProducts);
    on<GetCheckedProductsEvent>(onGetCheckedProducts);
    on<ToggleProductApprovalEvent>(onToggleProductApproval);
    on<DeleteProductEvent>(onDeleteProduct);
  }

  void onGetPendingProducts(
      GetPendingProductsEvent event, Emitter<ProductsState> emit) async {
    int page = 0;
    int limit = pendingProductLimit;

    emit(Loading());
    print('Getting Pending Products...');

    final pendingProducts = await _getProductsPendingUseCase(
        GetProductsParams(page: page, limit: limit));

    final checkedProducts = await _getCheckedProductsUseCase(
        GetProductsParams(page: page, limit: limit));

    pendingProducts.fold((l) => emit(Error(message: l.message)), (pending) {
      if (pending.isEmpty) {
        emit(Empty(const []));
      } else {
        checkedProducts.fold((l) => emit(Error(message: l.message)), (checked) {
          final mergedProducts = pending.map((apiProduct) {
            final apiProductModel = apiProduct as ProductModel;

            final dbProduct = checked.firstWhere(
              (dbProduct) => dbProduct.id == apiProductModel.id,
              orElse: () => apiProductModel,
            );

            final dbProductModel = dbProduct as ProductModel;

            return dbProductModel.copyWith(
              title: apiProduct.title,
              body: apiProduct.body,
            );
          }).toList();

          emit(Loaded(products: mergedProducts));
        });
      }
    });
  }

  void onGetCheckedProducts(
      GetCheckedProductsEvent event, Emitter<ProductsState> emit) async {
    int page = event.pageChecked;
    int limit = checkedProductLimit;
    List<ProductModel> products = event.products;

    emit(Loading());
    final response = await _getCheckedProductsUseCase(
        GetProductsParams(page: page, limit: limit));

    if (kDebugMode) {
      print('Getting Checked Products...');
    }

    response.fold((l) => emit(Error(message: l.message)), (r) {
      if (r.isEmpty) {
        emit(Loaded(products: products, pageChecked: page));
      } else {
        page++;
        products = [...products, ...r as List<ProductModel>];
        emit(Loaded(products: products, pageChecked: page));
      }
    });
  }

  Future<void> onToggleProductApproval(
    ToggleProductApprovalEvent event,
    Emitter<ProductsState> emit,
  ) async {
    if (state is! Loaded) return;
    final currentState = state as Loaded;

    final optimisticallyUpdatedProducts = currentState.products.map((p) {
      if (p.id == event.product.id) {
        return p.copyWith(approved: event.isApproved ? 1 : 0);
      }
      return p;
    }).toList();

    emit(Loaded(products: optimisticallyUpdatedProducts));

    // Perform the actual update
    final response = await _toggleProductApprovalUseCase(
      ToggleProductParams(
        product: event.product,
        isApproved: event.isApproved,
      ),
    );

    response.fold(
      (failure) {
        // If the update failed, revert to the original state
        emit(Loaded(products: currentState.products));
      },
      (success) {
        if (success < 1) {
          // If the toggle operation wasn't successful, revert to the original state
          emit(Loaded(products: currentState.products));
        }
        // If successful, we don't need to do anything as we've already updated the state
      },
    );
  }

  Future<void> onDeleteProduct(
    DeleteProductEvent event,
    Emitter<ProductsState> emit,
  ) async {
    if (state is! Loaded) return;
    final currentState = state as Loaded;

    final optimisticallyFilteredProducts = currentState.products.where((p) {
      return p.uuid != event.uuid;
    }).toList();

    emit(Loaded(products: optimisticallyFilteredProducts));

    final response = await _deleteProductUseCase(
      event.uuid,
    );

    response.fold(
      (failure) {
        // If the update failed, revert to the original state
        emit(Loaded(products: currentState.products));
      },
      (success) {
        if (success < 1) {
          // If the toggle operation wasn't successful, revert to the original state
          emit(Loaded(products: currentState.products));
        }
        // If successful, we don't need to do anything as we've already updated the state
      },
    );
  }
}
