import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import '/api_services.dart';
import '/login.dart';
import 'model/product_model.dart';

final apiProvider = Provider<ApiService>((ref) => ApiService());
final prodcutDataProvider = FutureProvider<List<ProductModel>>((ref) {
  return ref.read(apiProvider).getProducts();
});
final cartProvider = StateProvider<List<ProductModel>>((ref) => []);
void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RiverPod Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyLogin(),
    );
  }
}

class LogInView extends StatelessWidget {
  const LogInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("LOGIN"),
      ),
    );
  }
}
