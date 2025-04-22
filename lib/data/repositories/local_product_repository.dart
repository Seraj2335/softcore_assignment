import 'dart:convert';

import 'package:assignment/data/repositories/product_repository.dart';

import '../../constants.dart';
import '../models/product_model.dart';
import 'package:http/http.dart' as http;

class LocalProductRepository implements ProductRepository {

  @override
  Future<List<Product>> getProduct() async {
    print('>>>> Called');
    final response = await http.post(body: body, Uri.parse(baseUrl));
    final productData = jsonDecode(response.body)['product'] as List<dynamic>;
    List<Product> productList =
        productData.map((json) => Product.fromJson(json)).toList();

    print('>>>>>>${productList.length}');

    return productList;
  }

  @override
  String getImageUrl(String designCode) => '$imageBaseUrl$designCode.jpeg';
}
