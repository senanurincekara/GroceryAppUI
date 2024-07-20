// user info
class User {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String ProfilImagePath;
  final List<Address> address; // Changed to List<Address>

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.ProfilImagePath,
    required this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    var list = json['address'] as List;
    List<Address> addressList = list.map((i) => Address.fromJson(i)).toList();

    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      ProfilImagePath: json['ProfilImagePath'],
      address: addressList,
    );
  }
}

class Address {
  final int addressId;
  final String addressType;
  final String street;
  final String city;
  final String state;
  final String postalCode;

  Address({
    required this.addressId,
    required this.addressType,
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      addressId: json['addressId'],
      addressType: json['addressType'],
      street: json['street'],
      city: json['city'],
      state: json['state'],
      postalCode: json['postalCode'],
    );
  }
}

// orders
class Order {
  final int orderId;
  final String orderDate;
  final String status;
  final double totalPrice;
  final List<Item> items;

  Order({
    required this.orderId,
    required this.orderDate,
    required this.status,
    required this.totalPrice,
    required this.items,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    var list = json['items'] as List;
    List<Item> itemsList = list.map((i) => Item.fromJson(i)).toList();

    return Order(
      orderId: json['orderId'],
      orderDate: json['orderDate'],
      status: json['status'],
      totalPrice: json['totalPrice'].toDouble(),
      items: itemsList,
    );
  }
}

class Item {
  final String productId;
  final String name;
  final String imagePath;
  final int quantity;
  final double price;

  Item({
    required this.productId,
    required this.name,
    required this.imagePath,
    required this.quantity,
    required this.price,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      productId: json['productId'],
      name: json['name'],
      imagePath: json['imagePath'],
      quantity: json['quantity'],
      price: json['price'].toDouble(),
    );
  }
}

// currentOrder
class CurrentOrder {
  final int orderId;
  final String orderDate;
  final String status;
  final double totalPrice;
  final List<Item> items;

  CurrentOrder({
    required this.orderId,
    required this.orderDate,
    required this.status,
    required this.totalPrice,
    required this.items,
  });

  factory CurrentOrder.fromJson(Map<String, dynamic> json) {
    var list = json['items'] as List;
    List<Item> itemsList = list.map((i) => Item.fromJson(i)).toList();

    return CurrentOrder(
      orderId: json['orderId'],
      orderDate: json['orderDate'],
      status: json['status'],
      totalPrice: json['totalPrice'].toDouble(),
      items: itemsList,
    );
  }
}
