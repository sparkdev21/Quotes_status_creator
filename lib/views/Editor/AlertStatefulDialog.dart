import '/views/Editor/EditorNotifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class FontSizeSlider extends StatelessWidget {


   FontSizeSlider(
      {super.key});





  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          AlertDialog(
            contentPadding:
                const EdgeInsets.only(bottom: kBottomNavigationBarHeight - 22),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            content: SizedBox(
              height: 12,
              width: MediaQuery.of(context).size.width,
              child: SliderTheme(
                data: SliderThemeData(
                  activeTrackColor: Theme.of(context).colorScheme.onBackground,
                  inactiveTrackColor: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(0.2),
                  thumbColor: Theme.of(context).colorScheme.tertiary,
                  overlayColor: Theme.of(context)
                      .colorScheme
                      .inversePrimary
                      .withOpacity(0.2),
                  trackHeight: 2,
                ),
                child: Consumer(
                  builder: (context,ref,_) {
                    ref.watch(editorNotifier);

                    return Slider(
                      value: ref.watch(editorNotifier.notifier).textSize,
                      max: 42,
                      min: 12,
                      onChanged: (double value) {

                          ref.read(editorNotifier.notifier).setTextSize(value);


                      },
                    );
                  }
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
