import 'package:athendat/core/helpers/extensions.dart';
import 'package:athendat/features/home/data/models/product_model.dart';
import 'package:athendat/features/shared/presentation/widget/app_style.dart';
import 'package:athendat/features/shared/presentation/widget/reusable_text.dart';
import 'package:flutter/material.dart';

import 'package:athendat/features/home/presentation/bloc/products_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PendingProductCard extends StatefulWidget {
  final ProductModel product;
  final List<ProductModel> products;

  const PendingProductCard(
      {super.key, required this.product, required this.products});

  @override
  _PendingProductCardState createState() => _PendingProductCardState();
}

class _PendingProductCardState extends State<PendingProductCard> {
  bool? isApproved;

  @override
  void initState() {
    super.initState();
    isApproved = widget.product.approved == 1
        ? true
        : widget.product.approved == 0
            ? false
            : null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<ProductsBloc, ProductsState>(
      buildWhen: (previous, current) {
        if (current is Loaded) {
          final updatedProduct = current.products.firstWhere(
            (p) => p.id == widget.product.id,
            orElse: () => widget.product,
          );
          return updatedProduct != widget.product;
        }
        return false;
      },
      builder: (context, state) {
        final currentProduct = (state is Loaded)
            ? state.products.firstWhere(
                (p) => p.id == widget.product.id,
                orElse: () => widget.product,
              )
            : widget.product;

        return _buildCard(theme, context, currentProduct);
      },
    );
  }

  SizedBox _buildCard(
      ThemeData theme, BuildContext context, ProductModel currentProduct) {
    return SizedBox(
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: Card(
              shadowColor: theme.colorScheme.onTertiary.withOpacity(0.5),
              elevation: 10,
              child: CheckboxListTile(
                title: ReusableText(
                  //this substring is only for visual purposes,
                  text: widget.product.title.substring(0, 12).capitalize,
                  maxLines: 1,
                  style: appStyle(
                      22, theme.colorScheme.onSecondary, FontWeight.bold),
                ),
                subtitle: ReusableText(
                    text: widget.product.body.capitalize,
                    maxLines: 2,
                    style: appStyle(
                        20, theme.colorScheme.onSecondary, FontWeight.normal)),
                value: isApproved ?? false,
                onChanged: (value) {
                  setState(() {
                    isApproved = value;
                  });

                  context.read<ProductsBloc>().add(
                        ToggleProductApprovalEvent(
                          widget.products,
                          product: currentProduct,
                          isApproved: value ?? false,
                        ),
                      );
                },
                // tristate: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
