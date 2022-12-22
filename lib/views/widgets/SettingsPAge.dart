import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:quotes_status_creator/Constants/Thmes.dart';
import 'package:quotes_status_creator/Monetization/Banners/dynamic_banner.dart';

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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                flex: 2,
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
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
                            value: ref.watch(themeProvider.notifier).darkTheme,
                            // switchValue ??= true,
                            onChanged: (newValue) async {
                              // setState(() => switchValue = newValue);

                              // ref.watch(themeProvider.notifier).darkTheme =
                              //     !ref.watch(themeProvider.notifier).darkTheme;
                              ref
                                  .read(themeProvider.notifier)
                                  .toggleTheme(newValue);
                            },
                            activeColor:
                                FlutterFlowTheme.of(context).primaryColor,
                            inactiveTrackColor:
                                FlutterFlowTheme.of(context).primaryBackground,
                          ),
                        ],
                      ),
                      Text(
                        // 'Dark Theme\n ${ref.read(themeProvider.notifier).flexScheme}:',
                        'Choose Colors',
                        style: FlutterFlowTheme.of(context).subtitle2,
                      ),
                      Flexible(
                        child: ListView(
                          children: [
                            for (int i = 0; i < themeColors.length; i++)
                              GestureDetector(
                                  onTap: () => ref
                                      .read(themeProvider.notifier)
                                      .setColor(themeColors[i], i),
                                  child: Card(
                                    color: ref
                                                .read(themeProvider.notifier)
                                                .flexScheme ==
                                            themeColors[i]
                                        ? Theme.of(context).highlightColor
                                        : Theme.of(context).cardColor,
                                    child: ListTile(
                                      tileColor: Theme.of(context)
                                          .listTileTheme
                                          .tileColor,
                                      leading: Text(colorsname[i].toString()),
                                      trailing: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                  )),
                          ],
                        ),
                      ),
                      // Expanded(child: const )
                    ],
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: DynamicBanner(adsize: AdSize.largeBanner),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
