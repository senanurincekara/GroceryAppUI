import 'package:flutter/material.dart';
import 'package:groceryapp/Widgets/custom_tabBar.dart';
import 'package:groceryapp/components/ListProducts.dart';
import 'package:groceryapp/components/random_color.dart';

class ExplorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: DefaultTabController(
        length: 6, // Number of tabs
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Theme.of(context).backgroundColor,
                // color: Colors.blue,
                height: 60,
                child: TabBar(
                  isScrollable: true,
                  tabs: [
                    CustomTab(iconPath: 'assets/images/5.png', label: 'Fruits'),
                    CustomTab(
                        iconPath: 'assets/images/6.png', label: 'Vegetables'),
                    CustomTab(iconPath: 'assets/images/7.png', label: 'Dairy'),
                    CustomTab(iconPath: 'assets/images/8.png', label: 'Meat'),
                    CustomTab(iconPath: 'assets/images/5.png', label: 'Snacks'),
                    CustomTab(
                        iconPath: 'assets/images/5.png', label: 'Beverages'),
                  ],
                  indicatorColor: Color.fromARGB(255, 21, 0, 0),
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    ProductsGrid(products: fruits),
                    ProductsGrid(products: vegetables),
                    ProductsGrid(products: dairy),
                    ProductsGrid(products: dairy),
                    ProductsGrid(products: dairy),
                    ProductsGrid(products: dairy),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductsGrid extends StatelessWidget {
  final List<Product> products;

  const ProductsGrid({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of items per row
        mainAxisSpacing: 16.0,
        crossAxisSpacing: 16.0,
        childAspectRatio: 1,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductCard(product: products[index]);
      },
    );
  }
}

class Product {
  final int id;
  final String imagePath;
  final String imageName;
  final String price;

  Product({
    required this.id,
    required this.imagePath,
    required this.imageName,
    required this.price,
  });
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3),
      child: Container(
        width: 150,
        height: 220,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            width: 1,
            color: getRandomColor(),
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 7),
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    child: Image.asset(
                      product.imagePath,
                      width: 100,
                      height: 100,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, right: 8, left: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.imageName,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 3.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "\$" + product.price,
                            style: TextStyle(
                              fontSize: 14.0,
                              color: const Color.fromARGB(255, 212, 2, 2),
                            ),
                          ),
                          Icon(
                            Icons.shopping_cart,
                            color: const Color.fromARGB(255, 212, 2, 2),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
