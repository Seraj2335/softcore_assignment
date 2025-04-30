import '../models/product_model.dart';

abstract class ProductRepository {
  //link to fetch product data
  Future<List<Product>> getProduct(int page, int limits);

  // link for getting image url
  String getImageUrl(String designCode);
}
