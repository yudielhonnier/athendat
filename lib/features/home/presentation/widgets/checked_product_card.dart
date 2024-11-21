import 'package:athendat/core/helpers/extensions.dart';
import 'package:athendat/features/home/data/models/product_model.dart';
import 'package:athendat/features/home/presentation/widgets/product_detail_dialog.dart';
import 'package:athendat/features/shared/presentation/widget/app_style.dart';
import 'package:athendat/features/shared/presentation/widget/reusable_text.dart';
import 'package:flutter/material.dart';

class CheckedProductCard extends StatefulWidget {
  final ProductModel product;
  final Function(String id) onDelete;

  const CheckedProductCard(
      {super.key, required this.product, required this.onDelete});

  @override
  _CheckedProductCardState createState() => _CheckedProductCardState();
}

class _CheckedProductCardState extends State<CheckedProductCard> {
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
    return GestureDetector(
      onTap: () =>
          showProductDetails(context: context, product: widget.product),
      child: Card(
        shadowColor: theme.colorScheme.onTertiary.withOpacity(0.5),
        elevation: 10,
        child: ListTile(
          title: ReusableText(
            text: widget.product.title.substring(0, 12).capitalize,
            maxLines: 1,
            style: appStyle(22, theme.colorScheme.onSecondary, FontWeight.bold),
          ),
          subtitle: ReusableText(
              text: widget.product.body,
              maxLines: 2,
              style: appStyle(
                  20, theme.colorScheme.onSecondary, FontWeight.normal)),
          leading: IconButton(
              onPressed: () => widget.onDelete(widget.product.uuid),
              icon: const Icon(Icons.delete)),
        ),
      ),
    );
  }
}
