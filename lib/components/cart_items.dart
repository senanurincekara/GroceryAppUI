class CartItem {
  final String id;
  final String imagePath;
  final String name;
  final double price;

  final int quantity;

  CartItem({
    required this.id,
    required this.imagePath,
    required this.name,
    required this.price,
    required this.quantity,
  });
}
