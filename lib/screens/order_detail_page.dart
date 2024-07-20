import 'package:flutter/material.dart';
import 'package:groceryapp/components/random_color.dart';
import 'package:intl/intl.dart';
import 'package:groceryapp/components/userJsonFile.dart';
import 'package:lottie/lottie.dart'; // Adjust import as needed

class OrderDetailPage extends StatefulWidget {
  final Order order;
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  const OrderDetailPage({
    Key? key,
    required this.order,
    required this.isDarkMode,
    required this.toggleTheme,
  }) : super(key: key);

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  late bool isDarkMode;

  @override
  void initState() {
    super.initState();
    isDarkMode = widget.isDarkMode;
  }

  void _toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
    widget.toggleTheme();
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMMM d, y');
    final formattedDate =
        dateFormat.format(DateTime.parse(widget.order.orderDate));

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            isDarkMode ? Color.fromARGB(31, 198, 195, 195) : Colors.transparent,
        elevation: 0,
        leading: BackButton(color: isDarkMode ? Colors.white : Colors.black),
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.nightlight_round : Icons.wb_sunny),
            onPressed: _toggleTheme,
          ),
        ],
        title: Text(
          'Order Details',
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: height * 0.35,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? Color.fromARGB(31, 198, 195, 195)
                            : Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(50),
                        ),
                      ),
                      child: _buildAnimation(),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: height * 0.35,
                        width: 1,
                        decoration: BoxDecoration(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: height * 0.35,
                        decoration: BoxDecoration(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? Color.fromARGB(31, 198, 195, 195)
                        : Color.fromARGB(255, 255, 255, 255),
                  ),
                  child: SingleChildScrollView(
                    child: Container(
                      height: height * 0.7,
                      width: width,
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? Colors.black
                            : Color.fromARGB(255, 166, 239, 251),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                        ),
                        border: Border(
                          top: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                          left: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
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
                                        color: isDarkMode
                                            ? Colors.grey
                                            : Color.fromARGB(255, 1, 6, 9),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      '# ${widget.order.orderId}',
                                      style: TextStyle(
                                        color: isDarkMode
                                            ? Colors.grey
                                            : Color.fromARGB(255, 9, 61, 104),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: isDarkMode
                                        ? Colors.grey[850]
                                        : Colors.white,
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
                                        widget.order.status == 'Delivered'
                                            ? Icons.check_circle
                                            : widget.order.status ==
                                                    'Processing'
                                                ? Icons.hourglass_empty
                                                : widget.order.status ==
                                                        'Cancelled'
                                                    ? Icons.cancel
                                                    : Icons.help,
                                        color:
                                            widget.order.status == 'Delivered'
                                                ? (isDarkMode
                                                    ? Colors.grey
                                                    : Colors.green)
                                                : widget.order.status ==
                                                        'Processing'
                                                    ? (isDarkMode
                                                        ? Colors.grey
                                                        : Colors.orange)
                                                    : widget.order.status ==
                                                            'Cancelled'
                                                        ? (isDarkMode
                                                            ? Colors.grey
                                                            : Colors.red)
                                                        : Colors.grey,
                                        size: 18,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        '${widget.order.status}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color:
                                              widget.order.status == 'Delivered'
                                                  ? (isDarkMode
                                                      ? Colors.grey
                                                      : Colors.green)
                                                  : widget.order.status ==
                                                          'Processing'
                                                      ? (isDarkMode
                                                          ? Colors.grey
                                                          : Colors.orange)
                                                      : widget.order.status ==
                                                              'Cancelled'
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
                            SizedBox(height: 10),
                            Text(
                              'Date: $formattedDate',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isDarkMode
                                    ? Colors.white70
                                    : Colors.black87,
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  'Total: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: isDarkMode
                                        ? Colors.white70
                                        : Colors.black87,
                                  ),
                                ),
                                Text(
                                  '\$${widget.order.totalPrice.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: isDarkMode
                                        ? Colors.white70
                                        : Color.fromARGB(221, 113, 2, 2),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Items:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color:
                                    isDarkMode ? Colors.white70 : Colors.black,
                              ),
                            ),
                            SizedBox(height: 10),
                            Column(
                              children: widget.order.items.map((item) {
                                return Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: isDarkMode
                                        ? Colors.grey[800]
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        item.imagePath,
                                        width: 50,
                                        height: 50,
                                      ),
                                      SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.name,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: isDarkMode
                                                  ? Colors.white70
                                                  : Colors.black,
                                            ),
                                          ),
                                          Text(
                                            'Quantity: ${item.quantity}',
                                            style: TextStyle(
                                              color: isDarkMode
                                                  ? Colors.white70
                                                  : Colors.black54,
                                            ),
                                          ),
                                          Text(
                                            'Price: \$${item.price.toStringAsFixed(2)}',
                                            style: TextStyle(
                                              color: isDarkMode
                                                  ? Colors.white70
                                                  : Colors.black54,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnimation() {
    switch (widget.order.status) {
      case 'Delivered':
        return Center(child: Lottie.asset("assets/animations/delivered.json"));
      case 'Processing':
        return Center(
            child: Lottie.asset("assets/animations/deliveryGuy.json"));
      case 'Cancelled':
        return Center(
          child: Lottie.asset(
            "assets/animations/cancelled.json",
            width: 300,
            height: 300,
            fit: BoxFit.cover,
            animate: true,
            repeat: true,
          ),
        );
      default:
        return Center(child: Lottie.asset("assets/animations/default.json"));
    }
  }
}
