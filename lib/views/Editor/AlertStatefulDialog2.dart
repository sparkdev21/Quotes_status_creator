// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// class FontSizeNotfier extends ChangeNotifier{
//   double _initialFontSize=24;
//   double get initialFontSize=>_initialFontSize;
//
//   setFontSize(double value){
//     _initialFontSize=value;
//     notifyListeners();
//   }
//
// }
// final fontSizeManager=ChangeNotifierProvider<FontSizeNotfier>((ref) => FontSizeNotfier());
//
// class FontSizeSlider extends StatelessWidget {
//   final double initialFontSize;
//   final ValueChanged valueChanged;
//
//   FontSizeSlider(
//       {Key? key, required this.valueChanged, required this.initialFontSize})
//       : super(key: key);
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 20,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           AlertDialog(
//             contentPadding:
//             const EdgeInsets.only(bottom: kBottomNavigationBarHeight - 22),
//             backgroundColor: Colors.transparent,
//             elevation: 0.0,
//             content: SizedBox(
//               height: 12,
//               width: MediaQuery.of(context).size.width,
//               child: SliderTheme(
//                 data: SliderThemeData(
//                   activeTrackColor: Theme.of(context).colorScheme.onBackground,
//                   inactiveTrackColor: Theme.of(context)
//                       .colorScheme
//                       .onBackground
//                       .withOpacity(0.2),
//                   thumbColor: Theme.of(context).colorScheme.tertiary,
//                   overlayColor: Theme.of(context)
//                       .colorScheme
//                       .inversePrimary
//                       .withOpacity(0.2),
//                   trackHeight: 2,
//                 ),
//                 child: Consumer(
//                     builder: (context,ref,_) {
//                       ref.watch(fontSizeManager);
//
//                       return Slider(
//                         value: ref.watch(fontSizeManager.notifier).initialFontSize,
//                         max: 42,
//                         min: 12,
//                         onChanged: (double value) {
//
//                           ref.read(fontSizeManager.notifier).setFontSize(value);
//                           valueChanged(value);
//
//                         },
//                       );
//                     }
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
