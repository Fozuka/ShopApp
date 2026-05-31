import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../data/datasources/product_remote_data_source.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/usecases/get_product_by_id_use_case.dart';
import '../../domain/usecases/get_products_use_case.dart';

final httpClientProvider = Provider<http.Client>((ref) {
  final client = http.Client();
  ref.onDispose(client.close);
  return client;
});

final productRemoteDataSourceProvider = Provider<ProductRemoteDataSource>((
  ref,
) {
  return ProductRemoteDataSource(client: ref.watch(httpClientProvider));
});

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepositoryImpl(
    remoteDataSource: ref.watch(productRemoteDataSourceProvider),
  );
});

final getProductsUseCaseProvider = Provider<GetProductsUseCase>((ref) {
  return GetProductsUseCase(repository: ref.watch(productRepositoryProvider));
});

final getProductByIdUseCaseProvider = Provider<GetProductByIdUseCase>((ref) {
  return GetProductByIdUseCase(
    repository: ref.watch(productRepositoryProvider),
  );
});

final productsProvider = FutureProvider<List<Product>>((ref) {
  return ref.watch(getProductsUseCaseProvider)();
});

final productDetailsProvider = FutureProvider.family<Product, int>((ref, id) {
  return ref.watch(getProductByIdUseCaseProvider)(id);
});
