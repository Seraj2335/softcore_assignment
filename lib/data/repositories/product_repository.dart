import '../models/product_model.dart';

abstract class ProductRepository {
  //link to fetch product data
  Future<List<Product>> getProduct();

  // link for getting image url
  String getImageUrl(String designCode);
}
