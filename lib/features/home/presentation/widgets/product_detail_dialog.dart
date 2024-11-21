import 'package:athendat/core/constants/constants.dart';
import 'package:athendat/core/helpers/extensions.dart';
import 'package:athendat/features/home/data/models/product_model.dart';
import 'package:athendat/features/shared/presentation/widget/app_style.dart';
import 'package:athendat/features/shared/presentation/widget/height_spacer.dart';
import 'package:athendat/features/shared/presentation/widget/reusable_text.dart';
import 'package:flutter/material.dart';

showProductDetails(
    {required BuildContext context, required ProductModel product}) {
  return showDialog(
      context: context,
      builder: (context) {
        final theme = Theme.of(context);
        return Dialog(
          backgroundColor: theme.colorScheme.primary,
          insetPadding: const EdgeInsets.all(10),
          child: ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(AppConst.kRadius),
              ),
              child: ListView(
                padding: const EdgeInsets.all(20),
                shrinkWrap: true,
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReusableText(
                      text: 'Uuid :',
                      style: appStyle(
                          20, theme.colorScheme.onSecondary, FontWeight.bold)),
                  Text(
                    product.uuid,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const HeightSpacer(
                    height: 10,
                  ),
                  ReusableText(
                      text: 'Title :',
                      style: appStyle(
                          20, theme.colorScheme.onSecondary, FontWeight.bold)),
                  Text(
                    product.title.capitalize,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const HeightSpacer(
                    height: 10,
                  ),
                  ReusableText(
                      text: 'Description :',
                      style: appStyle(
                          20, theme.colorScheme.onSecondary, FontWeight.bold)),
                  Text(
                    product.body.capitalize,
                    style: const TextStyle(fontSize: 18),
                    textAlign: TextAlign.start,
                  ),
                  const HeightSpacer(
                    height: 10,
                  ),
                  ReusableText(
                      text: 'Status :',
                      style: appStyle(
                          20, theme.colorScheme.onSecondary, FontWeight.bold)),
                  product.approved == 1
                      ? const ReusableText(
                          text: 'Approved',
                          style: TextStyle(color: Colors.green, fontSize: 18),
                        )
                      : const Text(
                          'Not Approved',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                          ),
                        ),
                  Center(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('OK',
                          style: appStyle(18, theme.colorScheme.onSecondary,
                              FontWeight.w600)),
                    ),
                  )
                ],
              )),
        );
      });
}
