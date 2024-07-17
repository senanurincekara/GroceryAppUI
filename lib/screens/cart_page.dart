import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:groceryapp/provider/add_to_cart_provider.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
        centerTitle: true,
      ),
      body: cartProvider.itemCount == 0
          ? Center(child: Text('Your cart is empty!'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartProvider.itemCount,
                    itemBuilder: (ctx, index) {
                      final cartItem =
                          cartProvider.items.values.toList()[index];
                      return Card(
                        margin: const EdgeInsets.all(8),
                        child: ListTile(
                          leading: Image.asset(cartItem.imagePath),
                          title: Text(cartItem.name),
                          subtitle: Text(
                              '\$${cartItem.price} x ${cartItem.quantity}'),
                          trailing: Text(
                              '\$${(cartItem.price * cartItem.quantity).toStringAsFixed(2)}'),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total:',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Chip(
                        label: Text(
                          '\$${cartProvider.totalAmount.toStringAsFixed(2)}',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle checkout logic
                  },
                  child: Text('Checkout'),
                ),
              ],
            ),
    );
  }
}
