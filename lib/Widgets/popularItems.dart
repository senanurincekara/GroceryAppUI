import 'package:flutter/material.dart';
import 'package:groceryapp/components/random_color.dart';

class PopularItemsWidget extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  const PopularItemsWidget({
    super.key,
    required this.isDarkMode,
    required this.toggleTheme,
  });

  final List<Map<String, String>> popularItems = const [
    {
      "name": "Banana",
      "text": "Fresh fruits, try now!",
      "imagePath": "assets/images/popular/12.png",
      "price": "\$5"
    },
    {
      "name": "Pineapple",
      "text": "Fresh fruits, try now!",
      "imagePath": "assets/images/popular/13.png",
      "price": "\$7"
    },
    {
      "name": "Biscuits",
      "text": "Delicious, try now!",
      "imagePath": "assets/images/popular/14.png",
      "price": "\$3"
    },
    {
      "name": "Watermelon",
      "text": "Delicious, try now!",
      "imagePath": "assets/images/popular/15.png",
      "price": "\$6"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: popularItems.map((item) => buildPopularItem(item)).toList(),
        ),
      ),
    );
  }

  Widget buildPopularItem(Map<String, String> item) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        width: 155,
        height: 225,
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.grey[850] : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 1,
            color: getRandomColor(), // Use the imported function
          ),
          boxShadow: [
            BoxShadow(
              color: isDarkMode
                  ? Color.fromARGB(255, 0, 0, 0)
                  : Color.fromARGB(255, 210, 209, 209).withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 4,
            )
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Image.asset(
                  item['imagePath']!,
                  height: 130,
                ),
              ),
              Text(
                item['name']!,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              SizedBox(height: 5),
              Text(
                item['text']!,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: isDarkMode ? Colors.white70 : Colors.black87,
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item['price']!,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    Icons.add_shopping_cart_sharp,
                    color: Colors.red,
                    size: 25,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
