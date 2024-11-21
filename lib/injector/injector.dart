import 'package:athendat/core/resources/product_db_helper.dart';
import 'package:athendat/features/home/domain/usecase/delete_product_use_case.dart';
import 'package:athendat/features/home/domain/usecase/get_checked_products_use_case.dart';
import 'package:athendat/features/home/domain/usecase/toggle_product_approval_use_case.dart';
import 'package:athendat/features/home/presentation/bloc/products_bloc.dart';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../features/home/data/data_sources/local/product_local_data_source.dart';
import '../features/home/data/data_sources/remote/product_remote_data_source.dart';
import '../features/home/data/repository/product_repository_impl.dart';
import '../features/home/domain/repository/product_repository.dart';
import '../features/home/domain/usecase/get_pending_products_use_case.dart';

import '../core/network/network_info.dart';

final getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  initBlocs();
  initUseCases();
  initRepositories();
  initDataSources();
  initCores();
  await initExternals();
}

void initUseCases() {
  getIt.registerLazySingleton(() => GetPendingProductsUseCase(getIt()));
  getIt.registerLazySingleton(() => GetCheckedProductsUseCase(getIt()));
  getIt.registerLazySingleton(() => ToggleProductApprovalUseCase(getIt()));
  getIt.registerLazySingleton(() => DeleteProductUseCase(getIt()));
}

void initRepositories() {
  getIt.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      remoteDataSource: getIt(),
      localDataSource: getIt(),
      networkInfo: getIt(),
    ),
  );
}

void initDataSources() {
  getIt.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(getIt()),
  );
  getIt.registerLazySingleton<ProductLocalDataSource>(
    () => ProductLocalDataSourceImpl(
        sharedPreferences: getIt(), productDB: getIt()),
  );
}

void initCores() {
  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(getIt()),
  );
}

Future<void> initExternals() async {
  final prefs = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => prefs);

  getIt.registerLazySingleton(() => Dio());

  getIt.registerLazySingleton(() => Connectivity());

  getIt.registerLazySingleton(() => ProductDatabaseHelper());
}

void initBlocs() {
  getIt.registerFactory<ProductsBloc>(() => ProductsBloc(
        getIt(),
        getIt(),
        getIt(),
        getIt(),
      ));
}
