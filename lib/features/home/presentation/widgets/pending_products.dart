import 'package:athendat/core/constants/constants.dart';
import 'package:athendat/features/home/data/models/product_model.dart';
import 'package:athendat/features/home/presentation/bloc/products_bloc.dart';
import 'package:athendat/features/home/presentation/widgets/pending_product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PendingProductsList extends StatefulWidget {
  const PendingProductsList({
    super.key,
    required this.context,
    required this.products,
  });

  final BuildContext context;
  final List<ProductModel> products;

  @override
  State<PendingProductsList> createState() => _PendingProductsListState();
}

class _PendingProductsListState extends State<PendingProductsList> {
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
        child: ListView.builder(
          itemCount: widget.products.length,
          itemBuilder: (BuildContext context, int index) {
            return PendingProductCard(
              product: widget.products[index],
              products: widget.products,
            );
          },
        ),
        onRefresh: () => _onRefresh(context, 0, pendingProductLimit));
  }

  Future<void> _onRefresh(BuildContext context, int page, int limit) async {
    BlocProvider.of<ProductsBloc>(context)
        .add(GetPendingProductsEvent(page: page, limit: limit));
  }
}
