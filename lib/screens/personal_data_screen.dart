import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:groceryapp/components/userJsonFile.dart';

class PersonalDataPage extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  const PersonalDataPage(
      {Key? key, required this.isDarkMode, required this.toggleTheme})
      : super(key: key);

  @override
  State<PersonalDataPage> createState() => _PersonalDataPageState();
}

class _PersonalDataPageState extends State<PersonalDataPage> {
  late bool isDarkMode;

  User? user;
  List<Order>? orders;
  Order? currentOrder;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    isDarkMode = widget.isDarkMode;
    loadJsonData();
  }

  void _toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
    widget.toggleTheme();
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

      print('User: ${user?.name}');
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
          'Personal Data',
          style: Theme.of(context).textTheme.headline6!.copyWith(
                color: isDarkMode ? Colors.white : Colors.black,
              ),
        ),
        centerTitle: true,
      ),
      extendBodyBehindAppBar: true,
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView(
              physics: BouncingScrollPhysics(),
              children: [
                if (user != null) Image(),

                divider(),
                personalInfo()
                // personalMenus(),
                // divider(),
                // appMenus()
              ],
            ),
    );
  }

  Widget Image() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Center(
          child: CircleAvatar(
            backgroundColor: Colors.amber,
            radius: 100,
            backgroundImage: AssetImage(
              user!.ProfilImagePath,
            ),
            onBackgroundImageError: (error, stackTrace) {
              print('Error loading image: $error');
            },
          ),
        ),
      ),
    );
  }

  Widget divider() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Divider(
        height: 10,
        indent: 90,
        endIndent: 90,
        thickness: 1,
        color: Colors.black54,
      ),
    );
  }

  Widget personalInfo() {
    return Column(
      children: [
        Info(Icons.arrow_circle_right_outlined, Colors.deepOrangeAccent, "Name",
            user!.name),
        Info(Icons.arrow_circle_right_outlined, Colors.deepOrangeAccent,
            "Email", user!.email),
        Info(Icons.arrow_circle_right_outlined, Colors.deepOrangeAccent,
            "Phone number", user!.phone),
      ],
    );
  }

  Widget Info(IconData icon, Color color, String text, String text2) {
    return ListTile(
      leading: Container(
        child: Icon(
          icon,
          color: color,
        ),
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            color: color.withOpacity(0.09),
            borderRadius: BorderRadius.circular(16)),
      ),
      title: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
      trailing: Text(
        text2,
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
      ),
    );
  }
}
