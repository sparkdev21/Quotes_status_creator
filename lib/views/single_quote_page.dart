import 'dart:ui' as ui;
import '/models/love_quotes_english.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/Quotes/quote_repository.dart';

// final quoteRepositoryProvider = Provider((ref) => QuotesRepository());
// final quoteProvider = FutureProvider<List<QuotesModel>?>((ref) {
//   // access the provider above
//   final repository = ref.watch(quoteRepositoryProvider);
//   final index = ref.watch(indexProvider);
//   // use it to return a Futured
//   return repository.fetchQuotes(index);
// });
// final indexProvider = StateProvider((ref) => 0);

// class SingleQuotePAge extends ConsumerWidget {
//   final double _borderRadius = 24;
//   final int index;
//   final String author;

//   SingleQuotePAge(this.index, this.author);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     AsyncValue<List<QuotesModel>?> quotes = ref.watch(quoteProvider);
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Gradient Cards'),
//         ),
//         body: quotes.when(
//             loading: () => Center(child: const CircularProgressIndicator()),
//             error: (error, stack) => const Text('Oops'),
//             data: (quotes) => ListView.builder(
//                 itemCount: quotes!.length,
//                 itemBuilder: (context, index) {
//                   return Center(
//                     child: Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Text(quotes[index].content![0].msg)),
//                   );
//                 })));
//   }
// }

class PlaceInfo {
  final String name;
  final String category;
  final String location;
  final double rating;
  final Color startColor;
  final Color endColor;

  PlaceInfo(this.name, this.startColor, this.endColor, this.rating,
      this.location, this.category);
}

class CustomCardShapePainter extends CustomPainter {
  final double radius;
  final Color startColor;
  final Color endColor;

  CustomCardShapePainter(this.radius, this.startColor, this.endColor);

  @override
  void paint(Canvas canvas, Size size) {
    var radius = 24.0;

    var paint = Paint();
    paint.shader = ui.Gradient.linear(
        Offset(0, 0), Offset(size.width, size.height), [
      HSLColor.fromColor(startColor).withLightness(0.8).toColor(),
      endColor
    ]);

    var path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width - radius, size.height)
      ..quadraticBezierTo(
          size.width, size.height, size.width, size.height - radius)
      ..lineTo(size.width, radius)
      ..quadraticBezierTo(size.width, 0, size.width - radius, 0)
      ..lineTo(size.width - 1.5 * radius, 0)
      ..quadraticBezierTo(-radius, 2 * radius, 0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
