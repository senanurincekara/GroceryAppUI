import 'package:flutter/material.dart';

class CustomTab extends StatelessWidget {
  final String iconPath;
  final bool isDarkMode;
  final String label;

  const CustomTab(
      {Key? key,
      required this.iconPath,
      required this.label,
      required this.isDarkMode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            iconPath,
            width: 24,
            height: 24,
          ),
          Text(
            label,
            style: TextStyle(
              color: isDarkMode
                  ? const Color.fromARGB(255, 200, 198, 198)
                  : Colors.black,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
