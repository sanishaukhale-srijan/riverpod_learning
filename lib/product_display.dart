import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '/cart.dart';
import '/main.dart';

class ProductDisplay extends ConsumerWidget {
  const ProductDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prodData = ref.watch(prodcutDataProvider);
    //check
    final cart = ref.watch(cartProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("PRODUCTS"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Get.to(const Cart());
            },
          ),
        ],
      ),
      body: prodData.when(
        data: ((data) {
          return ListView.builder(
            itemBuilder: ((context, index) {
              return Column(
                children: [
                  ListTile(
                    title: Text(data[index].title),
                    subtitle: Text(
                      data[index].description,
                      maxLines: 4,
                    ),
                    leading: SizedBox(
                        height: 70,
                        width: 70,
                        child: Image.network(data[index].image)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (cart.contains(data[index])) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: const Text('ALREADY ADDED'),
                              action: SnackBarAction(
                                onPressed: () {},
                                label: '',
                              ),
                            ));
                          } else {
                            cart.add(data[index]);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: const Text('ADDED'),
                              action: SnackBarAction(
                                onPressed: () {},
                                label: '',
                              ),
                            ));
                          }
                        },
                        child: const Icon(Icons.add),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          if (cart.contains(data[index])) {
                            cart.remove(data[index]);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: const Text('REMOVED'),
                              action: SnackBarAction(
                                onPressed: () {
                                  cart.add(data[index]);
                                },
                                label: 'UNDO',
                              ),
                            ));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: const Text('NOT PRESENT IN CART'),
                              action: SnackBarAction(
                                onPressed: () {
                                  cart.add(data[index]);
                                },
                                label: 'ADD?',
                              ),
                            ));
                          }
                        },
                        child: const Icon(Icons.remove),
                      ),
                    ],
                  )
                ],
              );
            }),
            itemCount: data.length,
          );
        }),
        error: (error, stackTrace) => Text("ERROR: $error"),
        loading: (() {
          return const Center(
            child: CircularProgressIndicator(backgroundColor: Colors.red),
          );
        }),
      ),
    );
  }
}
