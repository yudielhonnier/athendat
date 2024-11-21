import 'package:athendat/core/constants/constants.dart';
import 'package:athendat/features/home/presentation/bloc/products_bloc.dart';
import 'package:athendat/features/home/presentation/page/desktop_body_home.dart';
import 'package:athendat/features/home/presentation/page/tablet_body_home.dart';
import 'package:athendat/features/shared/presentation/widget/responsive_layout.dart';
import 'package:athendat/injector/injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'mobile_body_home.dart';

//todo: finish design
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<ProductsBloc>()
            ..add(GetPendingProductsEvent(page: 0, limit: pendingProductLimit)),
        ),
      ],
      child: ResponsiveLayout(
          mobileBody: MobileHomeBody(context: context),
          tabletBody: TabletHomeBody(context: context),
          desktopBody: DesktopHomeBody(context: context)),
    );
  }
}
