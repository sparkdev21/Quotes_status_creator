import 'package:flutter/cupertino.dart';

class PopUpWidget extends StatelessWidget {
  final Widget child;
  const PopUpWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 50,
        width: 50,
        child: CupertinoContextMenu(
          actions: <Widget>[
            CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Remove Photo")),
            CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("exit"))
          ],
          child: child,
        ),
      ),
    );
  }
}
