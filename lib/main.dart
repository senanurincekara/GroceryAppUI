import 'package:flutter/material.dart';
import 'package:groceryapp/components/side_menu.dart';
import 'package:groceryapp/provider/add_to_cart_provider.dart';
import 'package:groceryapp/screens/home_page.dart';
import 'package:groceryapp/screens/explore_page.dart';
import 'package:groceryapp/screens/cart_page.dart';
import 'package:groceryapp/screens/my_orders_page.dart';
import 'package:groceryapp/screens/personal_data_screen.dart';
import 'package:groceryapp/screens/profile_addresses_page.dart';
import 'package:groceryapp/screens/profile_page.dart';
import 'package:groceryapp/components/bottom_navigation_bar.dart';
import 'package:groceryapp/theme/dark_theme.dart';
import 'package:groceryapp/theme/light_theme.dart';
import 'package:provider/provider.dart';

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => CartProvider()))
      ],
      child: MyApp(),
    ));

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDarkMode ? darkTheme : lightTheme,
      home: MainScreen(isDarkMode: isDarkMode, toggleTheme: toggleTheme),
      routes: {
        '/personalData': (context) =>
            PersonalDataPage(isDarkMode: isDarkMode, toggleTheme: toggleTheme),
        '/addresses': (context) =>
            AddressesPage(isDarkMode: isDarkMode, toggleTheme: toggleTheme),
        '/orders': (context) =>
            OrdersPage(isDarkMode: isDarkMode, toggleTheme: toggleTheme),
        // '/paymentMethods': (context) => PaymentMethodsPage(),
        // '/faqs': (context) => FaqsPage(),
        // '/community': (context) => CommunityPage(),
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  const MainScreen(
      {Key? key, required this.isDarkMode, required this.toggleTheme})
      : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  bool isCollapsed = true;
  late double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 500);
  late AnimationController _controller;
  int _navBarIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onTabTapped(int index) {
    setState(() {
      _navBarIndex = index;
    });
  }

  void toggleCollapse() {
    setState(() {
      if (isCollapsed) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
      isCollapsed = !isCollapsed;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    List<Widget> _pages = [
      HomePage(
        isDarkMode: widget.isDarkMode,
        toggleTheme: widget.toggleTheme,
        isCollapsed: isCollapsed,
        controller: _controller,
        toggleCollapse: toggleCollapse,
      ),
      ExplorePage(
        isDarkMode: widget.isDarkMode,
        toggleTheme: widget.toggleTheme,
      ),
      CartPage(
        isDarkMode: widget.isDarkMode,
        toggleTheme: widget.toggleTheme,
      ),
      ProfilePage(
        isDarkMode: widget.isDarkMode,
        toggleTheme: widget.toggleTheme,
      ),
    ];

    return WillPopScope(
      onWillPop: () async {
        if (!isCollapsed) {
          setState(() {
            _controller.reverse();
            isCollapsed = !isCollapsed;
          });
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Stack(
          children: <Widget>[
            SideMenu(isDarkMode: widget.isDarkMode),
            AnimatedPositioned(
              left: isCollapsed ? 0 : 0.6 * screenWidth,
              right: isCollapsed ? 0 : -0.2 * screenWidth,
              top: isCollapsed ? 0 : screenHeight * 0.1,
              bottom: isCollapsed ? 0 : screenHeight * 0.1,
              duration: duration,
              curve: Curves.fastOutSlowIn,
              child: Scaffold(
                appBar: AppBar(
                  title: const Text('Fresh Mart'),
                  leading: IconButton(
                    icon: AnimatedIcon(
                      icon: AnimatedIcons.menu_close,
                      progress: _controller,
                    ),
                    onPressed: toggleCollapse,
                  ),
                  actions: [
                    IconButton(
                      icon: Icon(widget.isDarkMode
                          ? Icons.nightlight_round
                          : Icons.wb_sunny),
                      onPressed: widget.toggleTheme,
                    ),
                  ],
                ),
                bottomNavigationBar: BottomNavBar(
                  isCollapsed: isCollapsed,
                  currentIndex: _navBarIndex,
                  onTap: onTabTapped,
                ),
                body: _pages[_navBarIndex],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
