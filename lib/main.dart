import 'dart:io';

import 'package:athendat/config/themes/theme_constants.dart';
import 'package:athendat/core/constants/constants.dart';
import 'package:athendat/core/resources/product_db_helper.dart';
import 'package:athendat/features/home/presentation/bloc/products_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'config/router/my_router.dart';
import 'injector/injector.dart';

//todo : add repository
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  await ProductDatabaseHelper().initializeDatabase();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<MyRouter>(
            lazy: false,
            create: (BuildContext createContext) => MyRouter(),
          )
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => getIt<ProductsBloc>()
                ..add(GetPendingProductsEvent(
                    limit: pendingProductLimit, page: 0)),
            ),
          ],
          child: Builder(builder: (BuildContext context) {
            final _router =
                Provider.of<MyRouter>(context, listen: false).router;

            return MaterialApp.router(
              routerConfig: _router,
              title: 'Athendat',
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: ThemeMode.light,
              debugShowCheckedModeBanner: false,
            );
          }),
        ));
  }
}
