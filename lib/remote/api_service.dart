import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:e_comm_app/model/product_model.dart';

class ApiService {
  static Future<List<Product>> fetchProducts() async {
    try {
      String url = 'https://fakestoreapi.com/products';
      var response = await Dio().get(url);
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed with status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
