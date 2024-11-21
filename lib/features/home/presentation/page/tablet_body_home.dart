import 'package:flutter/material.dart';

class TabletHomeBody extends StatelessWidget {
  const TabletHomeBody({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      //todo: implement tablet home page
      body: SizedBox(child: Text('tablet home')),
    );
  }
}
