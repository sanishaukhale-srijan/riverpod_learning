import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'main.dart';

class Cart extends ConsumerWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("CART"),
      ),
      body: Center(
        child: ListView.builder(
          itemBuilder: ((context, index) {
            return Column(
              children: [
                ListTile(
                  title: Text(cart[index].title),
                  subtitle: Text(
                    cart[index].description,
                    maxLines: 4,
                  ),
                  leading: SizedBox(
                      height: 70,
                      width: 70,
                      child: Image.network(cart[index].image)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("ADD TO CART"),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        cart.add(cart[index]);
                      },
                      child: const Icon(Icons.add),
                    )
                  ],
                )
              ],
            );
          }),
          itemCount: cart.length,
        ),
      ),
    );
  }
}
