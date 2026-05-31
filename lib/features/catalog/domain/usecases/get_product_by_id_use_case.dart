import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetProductByIdUseCase {
  final ProductRepository repository;

  const GetProductByIdUseCase({required this.repository});

  Future<Product> call(int id) {
    return repository.getProductById(id);
  }
}
