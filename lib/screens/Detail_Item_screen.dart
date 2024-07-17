import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groceryapp/provider/add_to_cart_provider.dart';
import 'package:groceryapp/screens/explore_page.dart';

import 'package:provider/provider.dart';

class ItemDetailsScreen extends StatefulWidget {
  final Product product;
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  const ItemDetailsScreen(
      {Key? key,
      required this.product,
      required this.isDarkMode,
      required this.toggleTheme})
      : super(key: key);

  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  late bool isDarkMode;
  int quantity = 1;

  @override
  void initState() {
    super.initState();
    isDarkMode = widget.isDarkMode;
  }

  void _toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
    widget.toggleTheme();
  }

  void _increaseQuantity() {
    setState(() {
      quantity++;
    });
  }

  void _decreaseQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  void _addToCart() {
    Provider.of<CartProvider>(context, listen: false).addItem(
      widget.product.id
          as String, // Ensure you have an ID in your Product model
      widget.product.price,
      widget.product.imageName,
      widget.product.imagePath,
      quantity, // Pass the quantity
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${widget.product.imageName} added to cart!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color: isDarkMode ? Colors.white : Colors.black,
        ),
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.nightlight_round : Icons.wb_sunny),
            onPressed: _toggleTheme,
          ),
        ],
        title: Text(
          'Details Food',
          style: Theme.of(context).textTheme.headline6!.copyWith(
                color: isDarkMode ? Colors.white : Colors.black,
              ),
        ),
        centerTitle: true,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Image(
            image: isDarkMode
                ? AssetImage(
                    'assets/images/background/detailPageBackgroundDarkMode.png')
                : AssetImage(
                    'assets/images/background/detailPageBackground.png'),
            height: size.height,
            fit: BoxFit.cover,
          ),
          ListView(
            padding: const EdgeInsets.only(top: kToolbarHeight + 16),
            children: [
              _image(),
              _details(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _image() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Center(
        child: Container(
          // color: Colors.amber,
          child: Image.asset(
            widget.product.imagePath ?? 'assets/images/placeholder.png',
            fit: BoxFit.cover,
            width: 280,
            height: 280,
          ),
        ),
      ),
    );
  }

  Widget _details() {
    return Container(
      // color: Colors.amber,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'FRESH MART',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              widget.product.imageName,
              style: TextStyle(
                fontSize: 30,
                letterSpacing: 1,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 25, 3, 3),
              ),
            ),
            const SizedBox(height: 18),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(15),
                    width: 150,
                    decoration: BoxDecoration(
                        color: isDarkMode
                            ? Colors.black12
                            : Color.fromARGB(221, 247, 244, 244),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all()),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(
                            CupertinoIcons.minus,
                            size: 12,
                            color: Colors.black87,
                          ),
                          onPressed: _decreaseQuantity,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "$quantity",
                          style: TextStyle(color: Colors.black87, fontSize: 18),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        IconButton(
                          icon: Icon(
                            CupertinoIcons.plus,
                            size: 15,
                            color: Colors.black87,
                          ),
                          onPressed: _increaseQuantity,
                        )
                      ],
                    ),
                  ),
                  Text(
                    '\$${widget.product.price * quantity}',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode
                          ? Colors.black87
                          : Color.fromARGB(255, 146, 33, 8),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Details : ",
              style: TextStyle(
                fontSize: 25,
                color: const Color.fromARGB(255, 35, 4, 4).withOpacity(0.8),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'details come here ',
              style: TextStyle(
                fontSize: 20,
                color: const Color.fromARGB(255, 6, 22, 15),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: _addToCart,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                      decoration: BoxDecoration(
                          color: isDarkMode
                              ? Colors.black12
                              : Color.fromARGB(221, 247, 244, 244),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all()),
                      child: Text(
                        "Add to Cart",
                        style: TextStyle(
                            color: isDarkMode
                                ? Colors.black87
                                : Color.fromARGB(255, 146, 33, 8),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: isDarkMode
                            ? Colors.black12
                            : Color.fromARGB(221, 247, 244, 244),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all()),
                    child: Icon(
                      Icons.favorite_outline,
                      color: Colors.black54,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
