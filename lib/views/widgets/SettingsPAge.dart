import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quotes_status_creator/Constants/Thmes.dart';

import '../../providers/ThemeProvider.dart';
import '../QuotesUI/flutter_flow_theme.dart';

import 'package:flutter/material.dart';

class SettingsUI extends StatefulWidget {
  const SettingsUI({Key? key}) : super(key: key);

  @override
  _SettingsUIState createState() => _SettingsUIState();
}

class _SettingsUIState extends State<SettingsUI> {
  bool? switchValue;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        automaticallyImplyLeading: false,
        title: Text(
          'Settings',
          style: FlutterFlowTheme.of(context).title2,
        ),
        actions: [
          // Padding(
          //   padding: EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
          //   child: FlutterFlowIconButton(
          //     borderColor: Colors.transparent,
          //     borderRadius: 30,
          //     buttonSize: 48,
          //     icon: Icon(
          //       Icons.close_rounded,
          //       color: FlutterFlowTheme.of(context).secondaryText,
          //       size: 30,
          //     ),
          //     onPressed: () async {
          //       Navigator.pop(context);
          //     },
          //   ),
          // ),
        ],
        centerTitle: false,
        elevation: 0,
      ),
      body: Consumer(builder: (context, ref, _) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      // 'Dark Theme\n ${ref.read(themeProvider.notifier).flexScheme}:',
                      'Dark Theme',
                      style: FlutterFlowTheme.of(context).subtitle2,
                    ),
                    Switch(
                      value: switchValue ??= true,
                      onChanged: (newValue) async {
                        setState(() => switchValue = newValue);

                        // ref.watch(themeProvider.notifier).darkTheme =
                        //     !ref.watch(themeProvider.notifier).darkTheme;
                        ref
                            .read(themeProvider.notifier)
                            .toggleTheme(switchValue!);
                      },
                      activeColor: FlutterFlowTheme.of(context).primaryColor,
                      inactiveTrackColor:
                          FlutterFlowTheme.of(context).primaryBackground,
                    ),
                  ],
                ),
                // Row(
                //   mainAxisSize: MainAxisSize.max,
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     IconButton(
                //       icon: ref.watch(themeProvider.notifier).darkTheme
                //           ? const Icon(Icons.light_mode_outlined)
                //           : const Icon(Icons.dark_mode_outlined),
                //       onPressed: () {
                //         ref.watch(themeProvider.notifier).darkTheme =
                //             !ref.watch(themeProvider.notifier).darkTheme;
                //         ref.read(themeProvider.notifier).toggleTheme(
                //             ref.watch(themeProvider.notifier).darkTheme);
                //       },
                //     ),
                //   ],
                // ),
                Text(
                  // 'Dark Theme\n ${ref.read(themeProvider.notifier).flexScheme}:',
                  'Choose Colors',
                  style: FlutterFlowTheme.of(context).subtitle2,
                ),
                // Expanded(
                //   child: ListView(
                //     children: [
                //       for (int i = 0; i < FlexScheme.values.length; i++)
                //         GestureDetector(
                //             onTap: () => ref
                //                 .read(themeProvider.notifier)
                //                 .setColor(FlexScheme.values[i]),

                //             // child:  ListTile(
                //             //   leading: Card(color:FlexScheme.blueWhale ),
                //             // )
                //             child: Card(
                //               color:
                //                   ref.read(themeProvider.notifier).flexScheme ==
                //                           FlexScheme.values[i]
                //                       ? Theme.of(context).splashColor
                //                       : Theme.of(context).cardColor,
                //               child: ListTile(
                //                 tileColor:
                //                     Theme.of(context).listTileTheme.tileColor,
                //                 leading: Text(FlexScheme.values[i]
                //                     .toString()
                //                     .split('.')[1]),
                //                 trailing: Icon(Icons.arrow_forward_ios),
                //               ),
                //             ))
                //     ],
                //   ),
                // )
                Expanded(
                  child: ListView(
                    children: [
                      for (int i = 0; i < themeColors.length; i++)
                        GestureDetector(
                            onTap: () => ref
                                .read(themeProvider.notifier)
                                .setColor(FlexScheme.values[i]),

                            // child:  ListTile(
                            //   leading: Card(color:FlexScheme.blueWhale ),
                            // )
                            child: Card(
                              color:
                                  ref.read(themeProvider.notifier).flexScheme ==
                                          FlexScheme.values[i]
                                      ? Theme.of(context).splashColor
                                      : Theme.of(context).cardColor,
                              child: ListTile(
                                tileColor:
                                    Theme.of(context).listTileTheme.tileColor,
                                leading: Text(colorsname[i].toString()),
                                trailing: Icon(Icons.arrow_forward_ios),
                              ),
                            ))
                    ],
                  ),
                )

                // Padding(
                //   padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 24),
                //   child: FFButtonWidget(
                //     onPressed: () async {
                //       Navigator.pop(context);
                //     },
                //     text: 'Save Changes',
                //     options: FFButtonOptions(
                //       width: 300,
                //       height: 50,
                //       color: FlutterFlowTheme.of(context).primaryColor,
                //       textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                //             fontFamily: 'Poppins',
                //             color: Colors.white,
                //           ),
                //       elevation: 2,
                //       borderSide: BorderSide(
                //         color: Colors.transparent,
                //         width: 1,
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class ThemeContainer extends StatelessWidget {
  const ThemeContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
