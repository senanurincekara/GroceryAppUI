import 'package:flutter/material.dart';
import 'package:groceryapp/Widgets/custom_tabBar.dart';
import 'package:groceryapp/components/ListProducts.dart';
import 'package:groceryapp/components/random_color.dart';
import 'package:groceryapp/screens/Detail_Item_screen.dart';

class ExplorePage extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  const ExplorePage({
    Key? key,
    required this.isDarkMode,
    required this.toggleTheme,
  }) : super(key: key);

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6, // Number of tabs
      child: Scaffold(
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                color: Theme.of(context).backgroundColor,
                height: 60,
                child: TabBar(
                  isScrollable: true,
                  tabs: [
                    CustomTab(
                      iconPath: 'assets/images/5.png',
                      label: 'Fruits',
                      isDarkMode: widget.isDarkMode,
                    ),
                    CustomTab(
                      iconPath: 'assets/images/6.png',
                      label: 'Vegetables',
                      isDarkMode: widget.isDarkMode,
                    ),
                    CustomTab(
                      iconPath: 'assets/images/7.png',
                      label: 'Dairy',
                      isDarkMode: widget.isDarkMode,
                    ),
                    CustomTab(
                      iconPath: 'assets/images/8.png',
                      label: 'Meat',
                      isDarkMode: widget.isDarkMode,
                    ),
                    CustomTab(
                      iconPath: 'assets/images/5.png',
                      label: 'Snacks',
                      isDarkMode: widget.isDarkMode,
                    ),
                    CustomTab(
                      iconPath: 'assets/images/5.png',
                      label: 'Beverages',
                      isDarkMode: widget.isDarkMode,
                    ),
                  ],
                  indicatorColor: Color.fromARGB(255, 21, 0, 0),
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    ProductsGrid(
                        products: fruits,
                        isDarkMode: widget.isDarkMode,
                        toggleTheme: widget.toggleTheme),
                    ProductsGrid(
                        products: vegetables,
                        isDarkMode: widget.isDarkMode,
                        toggleTheme: widget.toggleTheme),
                    ProductsGrid(
                        products: dairy,
                        isDarkMode: widget.isDarkMode,
                        toggleTheme: widget.toggleTheme),
                    ProductsGrid(
                        products: dairy,
                        isDarkMode: widget.isDarkMode,
                        toggleTheme: widget.toggleTheme),
                    ProductsGrid(
                        products: dairy,
                        isDarkMode: widget.isDarkMode,
                        toggleTheme: widget.toggleTheme),
                    ProductsGrid(
                        products: dairy,
                        isDarkMode: widget.isDarkMode,
                        toggleTheme: widget.toggleTheme),
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

class ProductsGrid extends StatefulWidget {
  final List<Product> products;
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  const ProductsGrid({
    Key? key,
    required this.products,
    required this.isDarkMode,
    required this.toggleTheme,
  }) : super(key: key);

  @override
  _ProductsGridState createState() => _ProductsGridState();
}

class _ProductsGridState extends State<ProductsGrid> {
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
      itemCount: widget.products.length,
      itemBuilder: (context, index) {
        return ProductCard(
          product: widget.products[index],
          isDarkMode: widget.isDarkMode,
          toggleTheme: widget.toggleTheme,
        );
      },
    );
  }
}

class Product {
  final String id;
  final String imagePath;
  final String imageName;
  final double price;

  Product({
    required this.id,
    required this.imagePath,
    required this.imageName,
    required this.price,
  });
}

class ProductCard extends StatelessWidget {
  final Product product;
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  const ProductCard({
    Key? key,
    required this.product,
    required this.isDarkMode,
    required this.toggleTheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ItemDetailsScreen(
                        product: product,
                        isDarkMode: isDarkMode,
                        toggleTheme: toggleTheme,
                      )));
        },
        child: Container(
          width: 150,
          height: 220,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              width: 1,
              color: getRandomColor(),
            ),
            color: isDarkMode ? Color.fromARGB(255, 79, 79, 79) : Colors.white,
            boxShadow: [
              BoxShadow(
                color:
                    const Color.fromARGB(255, 107, 107, 107).withOpacity(0.5),
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
                            color: isDarkMode
                                ? Color.fromARGB(255, 6, 5, 5)
                                : Color.fromARGB(255, 34, 29, 29),
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 3.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "\$${product.price}",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14.0,
                                color: isDarkMode
                                    ? Color.fromARGB(255, 6, 5, 5)
                                    : const Color.fromARGB(255, 212, 2, 2),
                              ),
                            ),
                            Icon(
                              Icons.shopping_cart,
                              color: isDarkMode
                                  ? Color.fromARGB(255, 6, 5, 5)
                                  : const Color.fromARGB(255, 212, 2, 2),
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
      ),
    );
  }
}
