// import 'package:flutter/material.dart';

// import '../views/QuotesUI/flutter_flow_theme.dart';

// class Clipman extends StatelessWidget {
//   Clipman({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Container(
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               fit: BoxFit.cover,
//               image: Image.asset(
//                 'assets/images/back.png',
//               ).image,
//             ),
//           ),
//         ),
//         Align(
//           alignment: AlignmentDirectional(0, -0.3),
//           child: Container(
//             height: 300,
//             width: 300,
//             decoration: BoxDecoration(
//               // image: DecorationImage(
//               //   fit: BoxFit.cover,
//               //   image: Image.asset(
//               //     'assets/images/back.png',
//               //   ).image,
//               // ),
//               boxShadow: [
//                 BoxShadow(
//                   blurRadius: 4,
//                   color: Color(0x33000000),
//                   offset: Offset(0, 2),
//                 ),
//                 BoxShadow(
//                   blurRadius: 4,
//                   color: Color(0x33000000),
//                   offset: Offset(2, 2),
//                 )
//               ],
//               borderRadius: BorderRadius.circular(10),
//               shape: BoxShape.rectangle,
//               border: Border.all(
//                 color: Theme.of(context).colorScheme.tertiary,
//               ),
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.max,
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Text(
//                   '--- Quote Of The Day ---',
//                   style: FlutterFlowTheme.of(context).bodyText1.override(
//                         fontFamily: 'Poppins',
//                         color: FlutterFlowTheme.of(context).primaryBtnText,
//                       ),
//                 ),
//                 Text(
//                   '\"It\'s okay to take\na break\".',
//                   textAlign: TextAlign.center,
//                   style: FlutterFlowTheme.of(context).bodyText1.override(
//                         fontFamily: 'Poppins',
//                         color: FlutterFlowTheme.of(context).lineColor,
//                         fontSize: 23,
//                       ),
//                 ),
//                 Text(
//                   '@ronaldo',
//                   style: FlutterFlowTheme.of(context).bodyText1.override(
//                         fontFamily: 'Noto Serif',
//                         color: FlutterFlowTheme.of(context).primaryBtnText,
//                         fontWeight: FontWeight.w100,
//                         fontStyle: FontStyle.italic,
//                       ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 40),
//           child: Align(
//             alignment: Alignment.topCenter,
//             child: IconButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 icon: Icon(
//                   Icons.arrow_back_ios,
//                   color: Colors.white,
//                 )),
//           ),
//         ),
//       ],
//     );
//   }
// }
