import 'package:flutter/material.dart';

class CustomTab extends StatelessWidget {
  final String iconPath;
  final String label;

  const CustomTab({Key? key, required this.iconPath, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final isSelected = DefaultTabController.of(context)!.index ==
    //     (DefaultTabController.of(context)!.length - 1);

    return Container(
      // width: 100,
      // height: 50,
      decoration: BoxDecoration(
        // borderRadius: BorderRadius.circular(12.0),
        // color: Colors.white,
        boxShadow: [
          // BoxShadow(
          //   color: Colors.grey.withOpacity(0.7),
          //   spreadRadius: 1,
          //   blurRadius: 3, // changes position of shadow
          // ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            iconPath,
            width: 24,
            height: 24,
            // Seçili olduğunda renk değişimi
          ),
          Text(
            label,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
