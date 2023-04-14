import 'dart:convert';

import 'package:http/http.dart';

import '/model/product_model.dart';

class ApiService {
  String url = "https://fakestoreapi.com/products";

  Future<List<ProductModel>> getProducts() async {
    Response response = await get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body);
      return result.map(((e) => ProductModel.fromJson(e))).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
