import 'dart:async';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:quotes_status_creator/providers/ThemeProvider.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:quotes_status_creator/utils/PageTrasition.dart';

import './post_list_view_hive_data.dart';
import './views/ParalelEffect/PageView/Hide_on_scroll.dart';
import './Locator/locator.dart';
import './injectors/hive_injector.dart';
import './views/Editor/SingleEditor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

import 'Constants/keys.dart';
import 'Monetization/AdmobHelper/AdmobHelper.dart';
import 'Monetization/Adstate.dart';
import 'utils/ReceiveIntent/Receive_intent.dart';
import 'package:provider/provider.dart' as pr;

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

  final initFuture = MobileAds.instance.initialize();
  final adstate = AdState(initFuture);
  await adstate.initAds();
  InitData initData = await init();

  await HiveInjector.setup();
  runApp(ProviderScope(
    child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // showPerformanceOverlay: true,
        home: pr.ChangeNotifierProvider(
          create: (_) => AdmobHelper(),
          child: AnnotatedRegion(
            value: SystemUiOverlayStyle(
              statusBarColor: Colors.black45,
            ),
            child: MyApp(
              initData: initData,
            ),
          ),
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
  Future<void> initOnsignal() async {
    if (!mounted) {
      return;
    }
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    OneSignal.shared.setAppId(oneSignalAppId);
    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      _navKey.currentState!.push(PageTransition(
          child: SimpleEditorPage(
            quote: ' ${result.notification.rawPayload!['alert']}',
            title: 'notify',
          ),
          type: PageTransitionType.scale));
    });
  }

  @override
  void initState() {
    ref.read(managedblogProvider);
    initOnsignal();

    super.initState();

    //This shared intent work when application is in memory
    _intentDataStreamSubscription =
        ReceiveSharingIntent.getTextStream().listen((String value) {
      _navKey.currentState!.pushNamed(
        showDataRoute,
        arguments: ShowDataArgument(value),
      );
    });

    ref.read(themeProvider.notifier).setThemeMode();
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
          appBarBackgroundSchemeColor: SchemeColor.background,
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
            return MaterialPageRoute(builder: (_) => HomePage());
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
