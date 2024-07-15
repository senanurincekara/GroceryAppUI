import 'package:flutter/material.dart';
import 'package:groceryapp/Widgets/headerCategories.dart';
import 'package:groceryapp/Widgets/popularItems.dart';
import 'package:groceryapp/Widgets/sliderList.dart';

class HomePage extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;
  final bool isCollapsed;
  final AnimationController controller;
  final VoidCallback toggleCollapse;

  const HomePage({
    Key? key,
    required this.isDarkMode,
    required this.toggleTheme,
    required this.isCollapsed,
    required this.controller,
    required this.toggleCollapse,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        borderRadius:
            BorderRadius.all(Radius.circular(isCollapsed ? 0.0 : 16.0)),
        type: MaterialType.card,
        animationDuration: const Duration(milliseconds: 500),
        color: Theme.of(context).scaffoldBackgroundColor,
        elevation: 8,
        child: ClipRRect(
          borderRadius:
              BorderRadius.all(Radius.circular(isCollapsed ? 0.0 : 16.0)),
          child: Scaffold(
            body: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      headerCategories(
                        isDarkMode: isDarkMode,
                        toggleTheme: toggleTheme,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20, left: 20, bottom: 2),
                        child: Text(
                          "Popular",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      PopularItemsWidget(
                        isDarkMode: isDarkMode,
                        toggleTheme: toggleTheme,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20, left: 20, bottom: 2),
                        child: Text(
                          "Delivery in 20 min always",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      CarouselSliderWidget(
                        isDarkMode: isDarkMode,
                        toggleTheme: toggleTheme,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
