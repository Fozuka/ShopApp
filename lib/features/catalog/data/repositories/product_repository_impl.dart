import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  const ProductRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<List<Product>> getProducts() async {
    final products = await remoteDataSource.fetchProducts();
    return products.map((product) => product.toEntity()).toList();
  }

  @override
  Future<Product> getProductById(int id) async {
    final product = await remoteDataSource.fetchProductById(id);
    return product.toEntity();
  }
}
