import 'dart:math';
import 'package:flutter/material.dart';

Widget headerCategories(
    {required bool isDarkMode, required VoidCallback toggleTheme}) {
  Color? previousColor;

  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    padding: const EdgeInsets.symmetric(horizontal: 3.0),
    child: Row(
      children: [
        CategoryCard(
            imagePath: 'assets/images/5.png',
            label: 'Fruits',
            isDarkMode: isDarkMode,
            toggleTheme: toggleTheme,
            previousColor: previousColor),
        CategoryCard(
            imagePath: 'assets/images/6.png',
            label: 'Vegetables',
            isDarkMode: isDarkMode,
            toggleTheme: toggleTheme,
            previousColor: previousColor),
        CategoryCard(
            imagePath: 'assets/images/3.png',
            label: 'Meats',
            isDarkMode: isDarkMode,
            toggleTheme: toggleTheme,
            previousColor: previousColor),
        CategoryCard(
            imagePath: 'assets/images/4.png',
            label: 'Milk&Eggs',
            isDarkMode: isDarkMode,
            toggleTheme: toggleTheme,
            previousColor: previousColor),
        CategoryCard(
            imagePath: 'assets/images/7.png',
            label: 'Drinks',
            isDarkMode: isDarkMode,
            toggleTheme: toggleTheme,
            previousColor: previousColor),
        CategoryCard(
            imagePath: 'assets/images/8.png',
            label: 'Fish',
            isDarkMode: isDarkMode,
            toggleTheme: toggleTheme,
            previousColor: previousColor),
        CategoryCard(
            imagePath: 'assets/images/9.png',
            label: 'Bakery',
            isDarkMode: isDarkMode,
            toggleTheme: toggleTheme,
            previousColor: previousColor),
        CategoryCard(
            imagePath: 'assets/images/11.png',
            label: 'Biscuits',
            isDarkMode: isDarkMode,
            toggleTheme: toggleTheme,
            previousColor: previousColor),
        CategoryCard(
            imagePath: 'assets/images/10.png',
            label: 'Cleansers',
            isDarkMode: isDarkMode,
            toggleTheme: toggleTheme,
            previousColor: previousColor),
        CategoryCard(
            imagePath: 'assets/images/3.png',
            label: 'Snacks',
            isDarkMode: isDarkMode,
            toggleTheme: toggleTheme,
            previousColor: previousColor),
      ],
    ),
  );
}

class CategoryCard extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;
  final String imagePath;
  final String label;
  Color? previousColor;

  CategoryCard({
    Key? key,
    required this.imagePath,
    required this.label,
    required this.isDarkMode,
    required this.toggleTheme,
    this.previousColor,
  }) : super(key: key);

  @override
  _CategoryCardState createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  late Color currentColor;

  @override
  void initState() {
    super.initState();
    currentColor = getRandomColor(widget.previousColor);
    widget.previousColor = currentColor;
  }

  Color getRandomColor(Color? previousColor) {
    final List<Color> colors = [
      Color.fromARGB(255, 196, 241, 253),
      Color.fromARGB(255, 253, 196, 196),
      Color.fromARGB(255, 253, 241, 196),
      Color.fromARGB(255, 196, 253, 196),
      Color.fromARGB(255, 241, 196, 253),
    ];
    final random = Random();
    Color newColor;
    do {
      newColor = colors[random.nextInt(colors.length)];
    } while (newColor == previousColor);
    return newColor;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80, // Fixed width for cards
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.isDarkMode ? Colors.grey[600] : currentColor,
                border: Border.all(width: 1),
                boxShadow: [
                  BoxShadow(
                    color: widget.isDarkMode
                        ? Color.fromARGB(255, 0, 0, 0)
                        : Color.fromARGB(255, 255, 255, 255).withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 4,
                  ),
                ],
              ),
              padding: const EdgeInsets.all(9.0),
              child: Image.asset(
                widget.imagePath,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              widget.label,
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
