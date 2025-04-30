import 'dart:convert';

import 'package:assignment/data/repositories/product_repository.dart';
import 'package:flutter/cupertino.dart';

import '../../constants.dart';
import '../models/product_model.dart';
import 'package:http/http.dart' as http;

class LocalProductRepository implements ProductRepository {
  @override
  Future<List<Product>> getProduct(int page, int limit) async {
    print('>>>>>>>. getProduct method called');

    try {
      final response = await http.post(
        body: {...body, 'page': page.toString(), 'limit': limit.toString()},
        Uri.parse(baseUrl),
      );

      print('>>>>>>>. Response Status: ${response.statusCode}');
      print('>>>>>>>. Response Body: ${response.body}');

      final productData = jsonDecode(response.body)['product'] as List<dynamic>;
      List<Product> productList =
      productData.map((json) => Product.fromJson(json)).toList();

      return productList;
    } catch (e) {
      print('>>>>>>>. Error in getProduct: $e');
      return []; // or throw the exception
    }
  }

  @override
  String getImageUrl(String designCode) => '$imageBaseUrl$designCode.jpeg';
}
