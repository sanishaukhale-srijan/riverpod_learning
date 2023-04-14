import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/providers.dart';

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
                Text("Quantity: ${cart[index].qty}"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (cart[index].qty == 1) {
                          cart.remove(cart[index]);
                        } else {
                          cart[index].qty--;
                        }
                      },
                      child: const Icon(Icons.remove),
                    ),
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
