import 'package:flutter/material.dart';

import '../../utils/Sizeconfig.dart';

class DashCardsItem extends StatelessWidget {
  final String title;
  final String imagePath;
  final String itemName;
  const DashCardsItem(
      {Key? key,
      required this.title,
      required this.imagePath,
      required this.itemName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Card(
      shadowColor: Colors.black,
      color: Theme.of(context).colorScheme.background.withOpacity(0.8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                imagePath,
                height: 70,
                width: 70,
                fit: BoxFit.cover,
              )),
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).brightness.index == 0
                    ? Colors.white
                    : Colors.black,
                fontSize: SizeConfig.safeBlockHorizontal! * 3.3),
          ),
          //SizeConfig.safeBlockHorizontal! * 3
        ],
      ),
    );
  }
}
