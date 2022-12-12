import 'dart:math' as math;

import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quotes_status_creator/views/widgets/Custom_dialog%20copy%202.dart';
import 'package:social_share/social_share.dart';

import '../../utils/PageTrasition.dart';
import '../Editor/SingleEditor.dart';
import '/views/Editor/EditorNotifier.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gradient_colors/gradient_colors.dart';

import '../../models/user_Quotes.dart';
import 'TrendingQuotes.dart';

final firebaseIdeaProvider =
    StreamProvider.autoDispose<List<UserQuotes>>((ref) {
  final stream = FirebaseFirestore.instance
      .collection('userquotes')
      .orderBy("status")
      .snapshots();
  return stream.map((snapshot) =>
      snapshot.docs.map((doc) => UserQuotes.fromJson(doc.data())).toList());
});

class UserQuotesPage extends ConsumerWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quoteController = TextEditingController();
  final CollectionReference _quotes =
      FirebaseFirestore.instance.collection('userquotes');
  final _numberForm = GlobalKey<FormState>();

  showEdit(context) {
    showDialog(
        context: context,
        builder: (context) => SingleChildScrollView(
              child: CustomSubmitDialogBox(
                descriptions: 'Hello from the sky',
                img: null,
                text: 'Done',
                exitButton: TextButton(
                    onPressed: () async {
                      Navigator.of(context).pop();

                      await _quotes.add({
                        "quote": _quoteController.text,
                        "user": _nameController.text,
                        "status": 1.0,
                        "featured": 0.0,
                      }).then((value) => print("Valued:$value"));
                      _nameController.clear();
                      _quoteController.clear();
                    },
                    child: Text(
                      "Submit",
                      style: TextStyle(fontSize: 18),
                    )),
                title: 'Submit Quotes',
                child: Form(
                  key: _numberForm,
                  child: Container(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        flex: 1,
                        fit: FlexFit.loose,
                        child: TextFormField(
                          style: TextStyle(color: Colors.black),
                          autofocus: true,
                          controller: _nameController,
                          validator: (inputValue) {
                            if (inputValue!.isEmpty) {
                              return "Please enter Name";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: "UserId",
                              border: OutlineInputBorder(),
                              labelText: 'Username',
                              labelStyle: TextStyle(color: Colors.blue)),
                          onChanged: (text) {},
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Flexible(
                        fit: FlexFit.loose,
                        flex: 2,
                        child: TextFormField(
                          style: TextStyle(color: Colors.black),
                          textInputAction: TextInputAction.send,
                          autofocus: true,
                          controller: _quoteController,
                          validator: (inputValue) {
                            if (inputValue!.isEmpty) {
                              return "Please enter Quote";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.blue),
                            border: OutlineInputBorder(),
                            labelText: 'Quotes',
                          ),
                          onChanged: (text) {},
                        ),
                      ),
                    ],
                  )),
                ),
              ),
            ));
  }

  bool _handleScrollNotification(notification, WidgetRef ref) {
    if (notification.depth == 0) {
      if (notification is UserScrollNotification) {
        final UserScrollNotification userScroll = notification;
        switch (userScroll.direction) {
          case ScrollDirection.forward:
            isHideBottomNavBar(true);
            ref.read(editorNotifier.notifier).setFloatingStatus(true);

            break;
          case ScrollDirection.reverse:
            isHideBottomNavBar(false);
            ref.read(editorNotifier.notifier).setFloatingStatus(false);

            break;
          case ScrollDirection.idle:
            break;
        }
      }
    }
    return false;
  }

  final Function(bool) isHideBottomNavBar;
  UserQuotesPage({
    required this.isHideBottomNavBar,
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(editorNotifier);
    ref.watch(firebaseIdeaProvider);
    return NotificationListener<ScrollNotification>(
      onNotification: ((notification) =>
          _handleScrollNotification(notification, ref)),
      child: Scaffold(
          body: Material(
            elevation: 2.0,
            child: ref.watch(firebaseIdeaProvider).when(
                loading: () => Center(child: const CircularProgressIndicator()),
                error: (error, stack) => Center(child: const Text('Oopsies')),
                data: (datas) {
                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: false,
                      itemCount: datas.length,
                      addAutomaticKeepAlives: true,
                      itemBuilder: (context, int i) {
                        if (datas[i].status == 0 && datas.length == 1)
                          return Center(child: Text("No Quotes Available"));

                        return i == 0 && datas[i].status == 0
                            ? SizedBox(
                                child: Text("status ${datas[i].status}"),
                              )
                            : // Generated code for this Container Widget...
                            Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(25, 8, 25, 8),
                                child: Material(
                                  color: Colors.transparent,
                                  elevation: 2,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.60,
                                    height: MediaQuery.of(context).size.height *
                                        0.2,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      gradient: LinearGradient(
                                          colors: GradientColors.values[i]),
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 12,
                                          color: Colors.green,
                                          offset: Offset(1, -3),
                                          spreadRadius: 1,
                                        )
                                      ],
                                      border: Border.all(
                                        color: Colors.blue,
                                        width: 1,
                                      ),
                                    ),
                                    child: Stack(
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.77),
                                            child: Align(
                                              alignment: Alignment.topRight,
                                              child: buttons(
                                                  context, datas[i].quote),
                                            )),
                                        Banner(
                                            message: "@${datas[i].user}",
                                            color: Colors.pink.shade700,
                                            location: BannerLocation.topStart),
                                        Align(
                                          alignment:
                                              AlignmentDirectional(-0.02, -1.5),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  gradient: LinearGradient(
                                                      colors: GradientColors
                                                              .values[
                                                          math.Random()
                                                              .nextInt(100)]),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors
                                                            .green.shade700,
                                                        offset: Offset(2, 3))
                                                  ]),
                                              child: Icon(Icons.star),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional(0, -0.3),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    37, 1, 24, 4),
                                            child: Text(
                                              "${datas[i].quote}",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16),
                                            ),
                                          ),
                                        ),
                                        // Align(
                                        //   alignment: Alignment.bottomRight,
                                        //   child: Padding(
                                        //       padding: EdgeInsetsDirectional
                                        //           .fromSTEB(4, 4, 14, 14),
                                        //       child: Text.rich(
                                        //         TextSpan(
                                        //           children: [
                                        //             // TextSpan(text: '@'),
                                        //             TextSpan(
                                        //               text: "@${datas[i].user}",
                                        //               style: TextStyle(
                                        //                   color: Colors.black54,
                                        //                   fontWeight:
                                        //                       FontWeight.bold),
                                        //             ),
                                        //           ],
                                        //         ),
                                        //       )),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                      });
                }),
          ),
          floatingActionButton: Visibility(
              visible: ref.watch(editorNotifier.notifier).showFloatingButton,
              child: FloatingActionButton(
                  child: Icon(Icons.add),
                  onPressed: (() {
                    showEdit(context);
                  })))),
    );
  }

  Widget buttons(context, msg) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: IconButton(
                onPressed: () {
                  SocialShare.shareOptions(msg);
                },
                icon: const Icon(
                  FontAwesomeIcons.share,
                  size: iconSize,
                )),
          ),
          Expanded(
            child: IconButton(
                onPressed: () {
                  SocialShare.copyToClipboard(msg);
                  Fluttertoast.showToast(msg: "Copied  to Clipboard");
                },
                icon: const Icon(
                  Icons.copy,
                  size: iconSize,
                )),
          ),
          Expanded(
            child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: SimpleEditorPage(
                            quote: msg,
                            title: "",
                          ),
                          type: PageTransitionType.leftToRight));
                },
                icon: const Icon(
                  FontAwesomeIcons.penToSquare,
                  size: iconSize,
                )),
          ),
        ],
      ),
    );
  }
}
