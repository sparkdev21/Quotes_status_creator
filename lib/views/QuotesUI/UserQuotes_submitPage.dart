import '/views/QuotesUI/Dashboard.dart';
import 'package:flutter/material.dart';

class SubmitPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const minHeight = kToolbarHeight;
    final windowHeight = MediaQuery.of(context).size.height - minHeight;
    final minSize = minHeight / windowHeight;
    return Stack(children: [
      ListView(children: []),
      Container(
        height: windowHeight,
        child: DraggableScrollableSheet(
          initialChildSize: minSize,
          minChildSize: minSize,
          builder: (_, controller) {
            return LayoutBuilder(builder: (_, box) {
              print('minHeight: $minHeight');
              print('height: ${box.maxHeight}');
              return Container(
                color: Theme.of(context).backgroundColor,
                child: ListView(
                    controller: controller,
                    children: [for (int i = 0; i < 2000; i++) QuotesCard()]),
              );
            });
          },
        ),
      ),
    ]);
  }
}
