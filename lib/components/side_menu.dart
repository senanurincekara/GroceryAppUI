import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  final bool isDarkMode;

  const SideMenu({Key? key, required this.isDarkMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 32.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: FractionallySizedBox(
            widthFactor: 0.6,
            heightFactor: 0.8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _Menus(context), // Pass context to _Menus
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _Menus(BuildContext context) {
    return Column(
      children: [
        menu(Icons.person_outline, Colors.deepOrangeAccent, "Personal Data",
            () {
          Navigator.pushNamed(context, '/personalData');
        }),
        menu(Icons.home, Colors.deepOrangeAccent, "Addresses", () {
          Navigator.pushNamed(context, '/addresses');
        }),
        menu(Icons.shopping_basket_outlined, Colors.deepOrangeAccent, "Orders",
            () {
          Navigator.pushNamed(context, '/orders');
        }),
        menu(Icons.payment_outlined, Colors.deepOrangeAccent, "Payment Methods",
            () {
          Navigator.pushNamed(context, '/paymentMethods');
        }),
      ],
    );
  }

  Widget menu(IconData icon, Color color, String text, VoidCallback onTap) {
    return ListTile(
      leading: Container(
        child: Icon(
          icon,
          color: isDarkMode ? Colors.white : color,
        ),
        height: 20,
        width: 20,
        decoration: BoxDecoration(
          color: isDarkMode ? color.withOpacity(0.1) : color.withOpacity(0.09),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      title: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: isDarkMode ? Colors.white : Colors.black87,
        ),
      ),
      onTap: onTap,
    );
  }
}
