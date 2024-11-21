import 'package:athendat/core/constants/constants.dart';
import 'package:athendat/core/helpers/extensions.dart';
import 'package:athendat/features/home/data/models/product_model.dart';
import 'package:athendat/features/home/presentation/bloc/products_bloc.dart';
import 'package:athendat/features/home/presentation/widgets/checked_product_card.dart';
import 'package:athendat/features/shared/presentation/widget/show_confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class CheckedProductsList extends StatefulWidget {
  const CheckedProductsList({
    super.key,
    required this.context,
    required this.products,
    required this.pageChecked,
  });

  final BuildContext context;
  final List<ProductModel> products;
  final int pageChecked;

  @override
  State<CheckedProductsList> createState() => _CheckedProductsListState();
}

class _CheckedProductsListState extends State<CheckedProductsList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Colors.white,
      child: LazyLoadScrollView(
        scrollOffset: checkedProductLimit,
        onEndOfPage: () =>
            _onEndOfPage(context, widget.pageChecked, checkedProductLimit),
        child: ListView.builder(
            itemCount: widget.products.length,
            itemBuilder: (context, index) => SizedBox(
                    child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: CheckedProductCard(
                        product: widget.products[index],
                        onDelete: (uuid) {
                          showConfirmDialog(
                              context: context,
                              message:
                                  'Are you sure to delete the product of local db?',
                              onConfirm: () {
                                if (uuid.isNotNullOrEmpty) {
                                  context.read<ProductsBloc>().add(
                                      DeleteProductEvent(
                                          products: widget.products,
                                          uuid: uuid));
                                }
                              });
                        },
                      ),
                    ),
                  ],
                ))),
      ),
      onRefresh: () => _onRefresh(context, 1, checkedProductLimit),
    );
  }

  Future<void> _onRefresh(BuildContext context, int page, int limit) async {
    BlocProvider.of<ProductsBloc>(context).add(GetCheckedProductsEvent(
        pageChecked: page, limit: limit, products: widget.products));
  }

  Future<void> _onEndOfPage(BuildContext context, int page, int limit) async {
    BlocProvider.of<ProductsBloc>(context).add(GetCheckedProductsEvent(
        pageChecked: page, limit: limit, products: widget.products));
  }
}
