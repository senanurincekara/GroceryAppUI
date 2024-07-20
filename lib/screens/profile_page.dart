import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:groceryapp/components/userJsonFile.dart';

class ProfilePage extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  const ProfilePage({
    Key? key,
    required this.isDarkMode,
    required this.toggleTheme,
  }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? user;
  List<Order>? orders;
  Order? currentOrder;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  Future<void> loadJsonData() async {
    try {
      final String response = await rootBundle.loadString('assets/data.json');
      final data = json.decode(response);

      setState(() {
        user = User.fromJson(data['user'] ?? {});
        orders = (data['orders'] as List? ?? [])
            .map((i) => Order.fromJson(i))
            .toList();
        currentOrder = Order.fromJson(data['currentOrder'] ?? {});
        isLoading = false;
      });

      print('Orders: ${orders?.length}');
      print('Current Order: ${currentOrder?.orderId}');
    } catch (e) {
      print('Error loading JSON data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView(
              physics: BouncingScrollPhysics(),
              children: [
                if (user != null) aboutUser(),
                divider(),
                personalMenus(),
                divider(),
                appMenus()
              ],
            ),
    );
  }

  Widget aboutUser() {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.amber,
        radius: 30,
        backgroundImage: AssetImage(
          user!.ProfilImagePath,
        ),
        onBackgroundImageError: (error, stackTrace) {
          print('Error loading image: $error');
        },
      ),
      title: Text(
        user!.name,
        style: TextStyle(
            color: widget.isDarkMode ? Colors.white : Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 18),
      ),
      subtitle: Text(
        user!.email,
        style: TextStyle(
            color: widget.isDarkMode ? Colors.white70 : Colors.black87,
            fontWeight: FontWeight.w400,
            fontSize: 16),
      ),
    );
  }

  Widget divider() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Divider(
        thickness: 1,
        color: widget.isDarkMode ? Colors.white54 : Colors.black54,
      ),
    );
  }

  Widget personalMenus() {
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
          Navigator.pushNamed(context, '/personalData');
        }),
      ],
    );
  }

  Widget appMenus() {
    return Column(
      children: [
        appmenu(
            Icons.person_outline, const Color.fromARGB(255, 34, 10, 3), "FAQs"),
        appmenu(Icons.textsms_outlined, const Color.fromARGB(255, 34, 10, 3),
            "Community"),
      ],
    );
  }

  Widget menu(IconData icon, Color color, String text, VoidCallback onTap) {
    return ListTile(
      leading: Container(
        child: Icon(
          icon,
          color: widget.isDarkMode ? Colors.white : color,
        ),
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: widget.isDarkMode
              ? color.withOpacity(0.1)
              : color.withOpacity(0.09),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      title: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: widget.isDarkMode ? Colors.white : Colors.black87,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: widget.isDarkMode ? Colors.white : Colors.black,
      ),
      onTap: onTap,
    );
  }

  Widget appmenu(IconData icon, Color color, String text) {
    return ListTile(
      leading: Container(
        child: Icon(
          icon,
          color: widget.isDarkMode ? Colors.white : color,
        ),
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          color: widget.isDarkMode
              ? color.withOpacity(0.1)
              : color.withOpacity(0.09),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      title: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: widget.isDarkMode ? Colors.white : Colors.black87,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: widget.isDarkMode ? Colors.white : Colors.black,
      ),
    );
  }
}
