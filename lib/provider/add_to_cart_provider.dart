import 'package:flutter/material.dart';
import '../components/cart_items.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(String productId, double price, String title, String imagePath,
      int quantity) {
    if (_items.containsKey(productId)) {
      // Update quantity if the item is already in the cart
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          imagePath: existingCartItem.imagePath,
          name: existingCartItem.name,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity +
              quantity, // Update the quantity correctly
        ),
      );
    } else {
      // Add new item to cart if it doesn't exist
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          imagePath: imagePath,
          name: title,
          price: price,
          quantity: quantity, // Use the provided quantity
        ),
      );
    }
    notifyListeners(); // Notify listeners of changes in the cart
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]!.quantity > 1) {
      // Decrease the quantity by 1 if more than one item exists
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          imagePath: existingCartItem.imagePath,
          name: existingCartItem.name,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity - 1,
        ),
      );
    } else {
      // Remove the item if the quantity is 1
      _items.remove(productId);
    }
    notifyListeners(); // Notify listeners of changes in the cart
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
