import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quotes_status_creator/providers/QuotesUINotifier.dart';

import '../../flutterflow/flutterflow_iconButton.dart';
import '../QuotesUI/flutter_flow_theme.dart';

import 'package:flutter/material.dart';

import 'flutter_flow_buttonWidget.dart';

class AboutdialogWidget extends ConsumerStatefulWidget {
  const AboutdialogWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<AboutdialogWidget> createState() => _AboutdialogWidgetState();
  // TODO: implement createState

}

class _AboutdialogWidgetState extends ConsumerState<AboutdialogWidget> {
  double? sliderValue;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool switchValue = true;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(mainQuotesProvider);
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFFFFFFFF),
      appBar: AppBar(
        backgroundColor: Color(0xFFFFFFFFF),
        automaticallyImplyLeading: false,
        title: Text(
          'Apply Filter',
          style: FlutterFlowTheme.of(context).title2,
        ),
        actions: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
            child: FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30,
              buttonSize: 48,
              icon: Icon(
                Icons.close_rounded,
                color: FlutterFlowTheme.of(context).secondaryText,
                size: 30,
              ),
              onPressed: () async {
                Navigator.pop(context);
              },
            ),
          ),
        ],
        centerTitle: false,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Auto Play',
                    style: FlutterFlowTheme.of(context).subtitle2,
                  ),
                  Switch(
                    value: switchValue,
                    onChanged: (newValue) async {
                      ref
                          .read(mainQuotesProvider.notifier)
                          .changeAutoplay(newValue);
                      setState(() => switchValue = newValue);
                    },
                    activeColor: FlutterFlowTheme.of(context).primaryColor,
                    inactiveTrackColor:
                        FlutterFlowTheme.of(context).primaryBackground,
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'AutoPlay Delay',
                    style: FlutterFlowTheme.of(context).subtitle2,
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                      child: Slider(
                        activeColor: FlutterFlowTheme.of(context).primaryColor,
                        inactiveColor:
                            FlutterFlowTheme.of(context).primaryBackground,
                        min: 5,
                        max: 20,
                        value: sliderValue ??= 6,
                        label: sliderValue.toString(),
                        divisions: 15,
                        onChanged: (newValue) {
                          setState(() => sliderValue = newValue);
                          ref
                              .read(mainQuotesProvider.notifier)
                              .changeAutodelay(newValue);
                        },
                      ),
                    ),
                  ),
                  Text(
                    ' ${ref.read(mainQuotesProvider.notifier).autoDelay} seconds',
                    style: FlutterFlowTheme.of(context).bodyText1,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                child: FFButtonWidget(
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                  text: 'Save Changes',
                  options: FFButtonOptions(
                    width: 300,
                    height: 50,
                    color: FlutterFlowTheme.of(context).primaryColor,
                    textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                        ),
                    elevation: 2,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
