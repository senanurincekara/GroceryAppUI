import 'package:flutter/material.dart';

class CarouselSliderWidget extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  const CarouselSliderWidget({
    super.key,
    required this.isDarkMode,
    required this.toggleTheme,
  });

  @override
  _CarouselSliderWidgetState createState() => _CarouselSliderWidgetState();
}

class _CarouselSliderWidgetState extends State<CarouselSliderWidget> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return _carouselSliderList();
  }

  Widget _carouselSliderList() {
    final List<String> imgList = [
      'assets/images/ads/3.png',
      'assets/images/ads/2.png',
      'assets/images/ads/4.png',
      'assets/images/ads/1.png',
    ];

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          height: 180,
          child: PageView.builder(
            itemCount: imgList.length,
            onPageChanged: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: AssetImage(imgList[index]),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(
              imgList.length,
              (index) => Indicator(
                isActive: _selectedIndex == index,
                isDarkMode: widget.isDarkMode,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class Indicator extends StatelessWidget {
  final bool isActive;
  final bool isDarkMode;

  const Indicator(
      {super.key, required this.isActive, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2.0),
      width: isActive ? 22.0 : 8.0,
      height: 8.0,
      decoration: BoxDecoration(
        color: isActive
            ? (isDarkMode ? Color.fromARGB(255, 209, 209, 209) : Colors.orange)
            : (isDarkMode ? Colors.white30 : Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
