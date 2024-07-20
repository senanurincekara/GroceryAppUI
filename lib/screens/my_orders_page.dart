import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:groceryapp/components/random_color.dart';
import 'package:groceryapp/components/userJsonFile.dart';
import 'package:groceryapp/screens/order_detail_page.dart';
import 'package:intl/intl.dart';

class OrdersPage extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  const OrdersPage({
    Key? key,
    required this.isDarkMode,
    required this.toggleTheme,
  }) : super(key: key);

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
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
    return DefaultTabController(
      length: 3,
      child: Scaffold(
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
            'My orders',
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
          ),
          centerTitle: true,
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : Container(
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
                          _tabs("Delivered"),
                          _tabs("Processing"),
                          _tabs("Cancelled"),
                        ],
                        indicatorColor: Color.fromARGB(255, 21, 0, 0),
                      ),
                    ),
                    Expanded(
                        child: TabBarView(
                      children: [
                        ordersGrid('Delivered'),
                        ordersGrid('Processing'),
                        ordersGrid('Cancelled'),
                      ],
                    )),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _tabs(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        boxShadow: [
          // Add shadow if needed
        ],
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: isDarkMode ? Colors.white70 : Colors.black,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget ordersGrid(String status) {
    List<Order> filteredOrders;

    if (status == 'Processing') {
      // Show currentOrder for the "Processing" tab
      filteredOrders = currentOrder != null ? [currentOrder!] : [];
    } else {
      // Filter orders based on the given status
      filteredOrders =
          orders?.where((order) => order.status == status).toList() ?? [];
    }

    return GridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 1.0,
        crossAxisSpacing: 0.0,
        mainAxisSpacing: 5,
        mainAxisExtent: 160,
      ),
      itemCount: filteredOrders.length,
      itemBuilder: (context, index) {
        final order = filteredOrders[index];
        final dateFormat = DateFormat('MMMM d, y');
        final formattedDate =
            dateFormat.format(DateTime.parse(order.orderDate));
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OrderDetailPage(
                  order: order,
                  isDarkMode: isDarkMode,
                  toggleTheme: _toggleTheme,
                ),
              ),
            );
          },
          child: Card(
            elevation: 5,
            child: Container(
              height: 290,
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey[850] : Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    width: 1, color: Color.fromARGB(255, 225, 217, 217)),
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
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.all(5),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Order ID: ',
                              style: TextStyle(
                                color: Color.fromARGB(255, 1, 6, 9),
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              '# ${order.orderId}',
                              style: TextStyle(
                                color: Color.fromARGB(255, 9, 61, 104),
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: isDarkMode ? Colors.grey[850] : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 1,
                              color:
                                  getRandomColor(), // Use the imported function
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: isDarkMode
                                    ? Color.fromARGB(255, 0, 0, 0)
                                    : Color.fromARGB(255, 210, 209, 209)
                                        .withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 4,
                              )
                            ],
                          ),
                          padding: EdgeInsets.all(4),
                          child: Row(
                            children: [
                              // Example icons for status
                              Icon(
                                order.status == 'Delivered'
                                    ? Icons.check_circle
                                    : order.status == 'Processing'
                                        ? Icons.hourglass_empty
                                        : order.status == 'Cancelled'
                                            ? Icons.cancel
                                            : Icons.help,
                                color: order.status == 'Delivered'
                                    ? (isDarkMode ? Colors.grey : Colors.green)
                                    : order.status == 'Processing'
                                        ? (isDarkMode
                                            ? Colors.grey
                                            : Colors.orange)
                                        : order.status == 'Cancelled'
                                            ? (isDarkMode
                                                ? Colors.grey
                                                : Colors.red)
                                            : Colors.grey,
                                size: 18,
                              ),
                              SizedBox(width: 5),
                              Text(
                                '${order.status}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: order.status == 'Delivered'
                                      ? (isDarkMode
                                          ? Colors.grey
                                          : Colors.green)
                                      : order.status == 'Processing'
                                          ? (isDarkMode
                                              ? Colors.grey
                                              : Colors.orange)
                                          : order.status == 'Cancelled'
                                              ? (isDarkMode
                                                  ? Colors.grey
                                                  : Colors.red)
                                              : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_month_outlined,
                          color: isDarkMode ? Colors.white70 : Colors.black54,
                        ),
                        SizedBox(width: 5),
                        Text(
                          '$formattedDate',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: isDarkMode
                                  ? Colors.white70
                                  : const Color.fromARGB(221, 33, 33, 33)),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 35,
                          width: 70,
                          decoration: BoxDecoration(
                            color: isDarkMode
                                ? Colors.grey[850]
                                : Color.fromARGB(255, 57, 147, 1),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 1,
                              color:
                                  getRandomColor(), // Use the imported function
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: isDarkMode
                                    ? Color.fromARGB(255, 0, 0, 0)
                                    : Color.fromARGB(255, 210, 209, 209)
                                        .withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 4,
                              )
                            ],
                          ),
                          child: Center(
                            child: Text(
                              '\$${order.totalPrice.toStringAsFixed(2)}',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: isDarkMode
                                      ? Colors.white70
                                      : Color.fromARGB(221, 255, 253, 253)),
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Color.fromARGB(255, 26, 26, 26),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
