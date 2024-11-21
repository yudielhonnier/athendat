import 'package:flutter/material.dart';

class LoadingStatusAdaptative extends StatelessWidget {
  const LoadingStatusAdaptative({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: CircularProgressIndicator.adaptive(
        backgroundColor: theme.colorScheme.onSecondary,
      ),
    );
  }
}
