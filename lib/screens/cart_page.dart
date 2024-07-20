import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:groceryapp/provider/add_to_cart_provider.dart';

class CartPage extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  const CartPage({
    Key? key,
    required this.isDarkMode,
    required this.toggleTheme,
  }) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
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
                      return Dismissible(
                        key: ValueKey(cartItem.id),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          cartProvider.removeItem(cartItem.id);
                        },
                        background: Container(
                          color: Theme.of(context).errorColor,
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                        child: Card(
                          margin: const EdgeInsets.all(10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: widget.isDarkMode
                                  ? Colors.grey[850]
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 1,
                                color: widget.isDarkMode
                                    ? Colors.grey[700]!
                                    : Color.fromARGB(255, 225, 217, 217),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: widget.isDarkMode
                                      ? Color.fromARGB(255, 0, 0, 0)
                                      : Color.fromARGB(255, 210, 209, 209)
                                          .withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            child: ListTile(
                              leading: Image.asset(cartItem.imagePath),
                              title: Text(
                                cartItem.name.toUpperCase(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: widget.isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              subtitle: Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.remove,
                                        color: widget.isDarkMode
                                            ? Colors.white
                                            : Colors.black),
                                    onPressed: () {
                                      cartProvider
                                          .removeSingleItem(cartItem.id);
                                    },
                                  ),
                                  Text(
                                    '${cartItem.quantity}',
                                    style: TextStyle(
                                      color: widget.isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.add,
                                        color: widget.isDarkMode
                                            ? Colors.white
                                            : Colors.black),
                                    onPressed: () {
                                      cartProvider.addItem(
                                        cartItem.id,
                                        cartItem.price,
                                        cartItem.name,
                                        cartItem.imagePath,
                                        1,
                                      );
                                    },
                                  ),
                                ],
                              ),
                              trailing: Text(
                                '\$${(cartItem.price * cartItem.quantity).toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: widget.isDarkMode
                                      ? Colors.white
                                      : Color.fromARGB(255, 119, 17, 9),
                                ),
                              ),
                            ),
                          ),
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
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color:
                              widget.isDarkMode ? Colors.white : Colors.black,
                        ),
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
