import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

class CustomShowcaseWidget extends StatefulWidget {
  final Widget child;
  final String description;
  final GlobalKey globalKey;

  const CustomShowcaseWidget({
    required this.description,
    required this.child,
    required this.globalKey,
  });

  @override
  _CustomShowcaseWidgetState createState() => _CustomShowcaseWidgetState();
}

class _CustomShowcaseWidgetState extends State<CustomShowcaseWidget> {
  GlobalKey _oneShowcaseKey = GlobalKey();

  startShowCase() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ShowCaseWidget.of(context).startShowCase([_oneShowcaseKey]);
    });
  }

  @override
  void initState() {
    startShowCase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Showcase(
        key: _oneShowcaseKey,
        showcaseBackgroundColor: Colors.pink.shade400,
        contentPadding: EdgeInsets.all(12),
        showArrow: false,
        disableAnimation: true,
        // title: 'Hello',
        // titleTextStyle: TextStyle(color: Colors.white, fontSize: 32),
        description: widget.description,
        descTextStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        // overlayColor: Colors.white,
        // overlayOpacity: 0.7,
        child: widget.child,
      );
  }
}

// class CustomShowcaseWidget extends StatelessWidget {
//   final Widget child;
//   final String description;
//   final GlobalKey globalKey;

//   const CustomShowcaseWidget({
//     required this.description,
//     required this.child,
//     required this.globalKey,
//   });

//   @override
//   Widget build(BuildContext context) => Showcase(
//         key: globalKey,
//         showcaseBackgroundColor: Colors.pink.shade400,
//         contentPadding: EdgeInsets.all(12),
//         showArrow: false,
//         disableAnimation: true,
//         // title: 'Hello',
//         // titleTextStyle: TextStyle(color: Colors.white, fontSize: 32),
//         description: description,
//         descTextStyle: TextStyle(
//           color: Colors.white,
//           fontWeight: FontWeight.bold,
//           fontSize: 16,
//         ),
//         // overlayColor: Colors.white,
//         // overlayOpacity: 0.7,
//         child: child,
//       );
// }
