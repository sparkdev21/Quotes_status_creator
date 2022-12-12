import 'dart:async';
import 'package:permission_handler/permission_handler.dart';
import 'package:quotes_status_creator/providers/ThemeProvider.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:quotes_status_creator/views/QuotesUI/UserQuotesPage.dart';

import './post_list_view_hive_data.dart';
import './views/ParalelEffect/PageView/Hide_on_scroll.dart';
import './views/QuotesUI/FeaturedQuotes.dart';
import './views/QuotesUI/TrendingQuotes.dart';
import 'package:firebase_core/firebase_core.dart';
import './Locator/locator.dart';
import './injectors/hive_injector.dart';
import './utils/Utilities.dart';
import './views/Editor/SingleEditor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

import 'utils/ReceiveIntent/Receive_intent.dart';
import 'views/Editor/FlutterUtils.dart';

const String homeRoute = "home";
const String showDataRoute = "showData";

Future<InitData> init() async {
  String sharedText = "";
  String routeName = homeRoute;
  //This shared intent work when application is closed
  String? sharedValue = await ReceiveSharingIntent.getInitialText();
  if (sharedValue != null) {
    sharedText = sharedValue;
    routeName = showDataRoute;
  }
  return InitData(sharedText, routeName);
}

void main() async {
  setup();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await requestPermission(Permission.storage);
  InitData initData = await init();
  await HiveInjector.setup();
  runApp(ProviderScope(
    child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // showPerformanceOverlay: true,
        home: MyApp(
          initData: initData,
        )),
  ));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key, required this.initData}) : super(key: key);

  final InitData initData;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  final _navKey = GlobalKey<NavigatorState>();

  late StreamSubscription _intentDataStreamSubscription;

  @override
  void initState() {
    ref.read(managedblogProvider);
    AppUtil.requestPermission();
    super.initState();

    //This shared intent work when application is in memory
    _intentDataStreamSubscription =
        ReceiveSharingIntent.getTextStream().listen((String value) {
      _navKey.currentState!.pushNamed(
        showDataRoute,
        arguments: ShowDataArgument(value),
      );
    });

    ref.read(featuredQuotesProvider);

    ref.read(trendingQuotesProvider);
    ref.read(userQuotesProvider);
  }

  @override
  void dispose() {
    super.dispose();
    _intentDataStreamSubscription.cancel();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ref.watch(themeProvider);

    return MaterialApp(
      navigatorKey: _navKey,
      debugShowCheckedModeBanner: false,
      themeMode: ref.watch(themeProvider.notifier).themeMode,

// If you do not have a themeMode switch, uncomment this line
// to let the device system mode control the theme mode:
// themeMode: ThemeMode.system,

      theme: FlexThemeData.light(
        scheme: ref.watch(themeProvider.notifier).flexScheme,
        surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
        blendLevel: 20,

        appBarStyle: FlexAppBarStyle.background,
        appBarOpacity: 0.90,
        applyElevationOverlayColor: false,
        appBarElevation: 1.0,

        subThemesData: const FlexSubThemesData(
          blendOnLevel: 15,
          blendOnColors: false,
          inputDecoratorRadius: 17.0,
          appBarBackgroundSchemeColor: SchemeColor.primary,
          navigationBarOpacity: 0.86,
          fabRadius: 40.0,
          fabSchemeColor: SchemeColor.background,
          tabBarIndicatorSchemeColor: SchemeColor.onPrimary,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        // To use the playground font, add GoogleFonts package and uncomment
        // fontFamily: GoogleFonts.notoSans().fontFamily,
      ),
      darkTheme: FlexThemeData.dark(
        scheme: ref.watch(themeProvider.notifier).flexScheme,
        surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
        blendLevel: 15,
        appBarStyle: FlexAppBarStyle.background,
        appBarOpacity: 0.90,
        appBarElevation: 1.0,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 30,
          inputDecoratorRadius: 17.0,
          navigationBarOpacity: 0.86,
          fabRadius: 40.0,
          fabSchemeColor: SchemeColor.secondary,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        // To use the playground font, add GoogleFonts package and uncomment
        // fontFamily: GoogleFonts.notoSans().fontFamily,
      ),
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case homeRoute:
            // return MaterialPageRoute(builder: (_) => QuotesApp());
            return MaterialPageRoute(builder: (_) => HideOnScroll());
          case showDataRoute:
            {
              if (settings.arguments != null) {
                final args = settings.arguments as ShowDataArgument;
                return MaterialPageRoute(
                    builder: (_) => SimpleEditorPage(
                          quote: args.sharedText,
                          title: "Editing Sharing Intent",
                        ));
              } else {
                return MaterialPageRoute(
                    builder: (_) => SimpleEditorPage(
                          quote: widget.initData.sharedText,
                          title: "Editing Sharing Intent",
                        ));
              }
            }
        }
        return null;
      },
      initialRoute: widget.initData.routeName,
    );
  }
}
