import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'api_services.dart';
import 'login.dart';
import 'model/product_model.dart';

final apiProvider = Provider<ApiService>((ref) => ApiService());
final productDataProvider = FutureProvider<List<ProductModel>>((ref) {
  return ref.read(apiProvider).getProducts();
});
final cartProvider = StateProvider<List<ProductModel>>((ref) => []);
final loginStatus = StateProvider<LoginState>((ref) => LoginState.loginInit);
final quantity = StateProvider((ref) => []);