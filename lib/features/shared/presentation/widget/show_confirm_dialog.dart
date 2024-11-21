import 'package:athendat/core/constants/constants.dart';
import 'package:athendat/features/shared/presentation/widget/app_style.dart';
import 'package:athendat/features/shared/presentation/widget/reusable_text.dart';
import 'package:flutter/material.dart';

showConfirmDialog(
    {required BuildContext context,
    required String message,
    required Function() onConfirm,
    bool wrap = true,
    String? btnText}) {
  final theme = Theme.of(context);

  return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(10),
          child: ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(AppConst.kRadius),
              ),
              child: Container(
                  padding: const EdgeInsets.all(10),
                  height: AppConst.kHeight * 0.2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ReusableText(
                          wrap: wrap,
                          text: message,
                          style: appStyle(18, theme.colorScheme.onSecondary,
                              FontWeight.w600)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('Cancel',
                                style: appStyle(18, theme.colorScheme.shadow,
                                    FontWeight.w600)),
                          ),
                          TextButton(
                            onPressed: () {
                              onConfirm();
                              Navigator.pop(context);
                            },
                            child: Text(btnText ?? 'OK',
                                style: appStyle(
                                    18,
                                    theme.colorScheme.onTertiary,
                                    FontWeight.w600)),
                          ),
                        ],
                      )
                    ],
                  ))),
        );
      });
}
