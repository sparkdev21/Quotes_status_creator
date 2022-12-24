import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../Controllers/OfflineHiveDataControllers.dart';
import '../../../Controllers/QuotesController.dart';
import '../../../Monetization/AdHelpers.dart';
import '../../../Monetization/NativeAds/native_banner.dart';
import '../../../repositories/Settings/Settings.dart';
import '../../QuotesUI/FeaturedQuotes.dart';
import '../../QuotesUI/TrendingQuotes.dart';
import '../../widgets/SettingsPAge.dart';
import '/views/QuotesUI/Dashboard.dart';
import '/views/QuotesUI/UserQuotesPage.dart';
import 'package:flutter/material.dart';

import '../../widgets/Sidebar.dart';
import '../parallelx_effect.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  _HideOnScrollState createState() => _HideOnScrollState();
}

class _HideOnScrollState extends ConsumerState<HomePage>
    with SingleTickerProviderStateMixin {
  int selectedIndex = 0;
  late AnimationController animationController;
  late List<Widget> _pages;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  // void _onItemTapped(int index, BuildContext ctx) {
  //   setState(() {
  //     if (index == 0) {
  //       Scaffold.of(ctx).openDrawer();
  //       return;
  //     }
  //     _selectedIndex = index;
  //   });
  // }

  late BannerAd _bannerAd;
  bool _bannerReady = false;

  @override
  void didChangeDependencies() {
    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerGoogleAdmobOnlyAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _bannerReady = true;
            debugPrint("Adbanner Admob Widget is loading:SatefulBanner2");
          });
        },
        onAdOpened: (ad) => debugPrint('Ad opened.'),
        onAdClosed: (ad) => debugPrint('Ad closed.'),
        onAdImpression: (Ad ad) =>
            debugPrint('$Ad Add Impression Banner Small Done.'),
        onAdFailedToLoad: (ad, err) {
          setState(() {
            _bannerReady = false;
          });
        },
      ),
    );
    _bannerAd.load();

    _pages = <Widget>[
      // CallsPage(
      //   isHideBottomNavBar: (isHideBottomNavBar) {
      //     isHideBottomNavBar
      //         ? animationController.forward()
      //         : animationController.reverse();
      //   },
      // ),
      // Dashboard(isHideBottomNavBar: (isHideBottomNavBar)
      //       ? animationController.forward()
      //       : animationController.reverse();)
      // PostHiveData(isHideBottomNavBar: (isHideBottomNavBar) {
      //   isHideBottomNavBar
      //       ? animationController.forward()
      //       : animationController.reverse();
      // }),

      MainDashBoard(isHideBottomNavBar: (isHideBottomNavBar) {
        isHideBottomNavBar
            ? animationController.forward()
            : animationController.reverse();
      }),
      CategoriesParallax(isHideBottomNavBar: (isHideBottomNavBar) {
        isHideBottomNavBar
            ? animationController.forward()
            : animationController.reverse();
      }),
      UserQuotesBlogPage(
        isHideBottomNavBar: (isHideBottomNavBar) {
          isHideBottomNavBar
              ? animationController.forward()
              : animationController.reverse();
        },
      ),
      SettingsUI()

      // SubmitPage(),
      // InnerSwiper(),
      // CategoryGrid()
      // FlowBack()
    ];

    super.didChangeDependencies();
  }

  @override
  void initState() {
    ref.read(featuredQuotesProvider);

    ref.read(trendingQuotesProvider);
    ref.read(userQuotesProvider);
    ref.read(settingsDataProvider);
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
    debugPrint("dispded Adbanner Widget is Disposed:SatefulBanner");
    _bannerAd.dispose();
    Fluttertoast.showToast(msg: "disposed");
  }

  @override
  Widget build(BuildContext context) {
    var scaffold = AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: Theme.of(context).brightness.index == 0
            ? Brightness.light
            : Brightness.dark,
        statusBarColor: Theme.of(context).colorScheme.background,
      ),
      child: Scaffold(
        backgroundColor:
            Theme.of(context).colorScheme.background.withOpacity(0.9),
        key: scaffoldKey,
        appBar: AppBar(
          actions: [
            // IconButton(
            //     onPressed: () async {
            //       Navigator.push(
            //           context,
            //           PageTransition(
            //               type: PageTransitionType.rightToLeft,
            //               child: Material(child: Clipman())));
            //     },
            //     icon: Icon(Icons.download)),
            IconButton(
                onPressed: () async {
                  OfflineHiveDataController().clearAll();
                  QuotesController().clearAll();
                },
                icon: Icon(Icons.cabin)),
            // IconButton(
            //     onPressed: () async {
            //       Navigator.push(
            //           context,
            //           PageTransition(
            //               type: PageTransitionType.rightToLeft,
            //               child: FireBaseData()));
            //     },
            //     icon: Icon(Icons.format_quote_sharp)),
            // IconButton(
            //     onPressed: () async {
            //       Navigator.push(
            //           context,
            //           PageTransition(
            //               type: PageTransitionType.rightToLeft,
            //               child: InnerSwiper("dm", [])));
            //     },
            //     icon: Icon(Icons.near_me)),
            // IconButton(
            //     onPressed: () async {
            //       Navigator.push(
            //           context,
            //           PageTransition(
            //               type: PageTransitionType.rightToLeft,
            //               child: FavouritePage()));
            //     },
            //     icon: Icon(Icons.format_quote_sharp))
          ],
          title: Text("Home"),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                  color: Theme.of(context).backgroundColor,
                  child: const NativeBanner()),
              Expanded(
                child: _pages.elementAt(selectedIndex),
              ),
            ],
          ),
        ),
        // body: IndexedStack(
        //   children: _pages,
        //   index: _selectedIndex,
        // ),
        bottomNavigationBar:
            // _bannerReady
            //     ? SizedBox(
            //         width: _bannerAd.size.width.toDouble(),
            //         height: _bannerAd.size.height.toDouble(),
            //         child: AdWidget(ad: _bannerAd),
            //       )

            SizeTransition(
                sizeFactor: animationController,
                axisAlignment: -1.0,
                child: BottomNavigationBar(
                  selectedItemColor: Colors.blue,
                  backgroundColor: Colors.amberAccent,
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(selectedIndex == 0 ? Icons.menu : Icons.home),
                      label: selectedIndex == 0 ? "Menu" : "Home",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.camera),
                      label: 'Categories',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.local_fire_department_rounded),
                      label: 'User Quotes',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.settings),
                      label: 'Settings',
                    ),
                    // BottomNavigationBarItem(
                    //   icon: Icon(Icons.settings),
                    //   label: 'Settings',
                    // ),
                    // BottomNavigationBarItem(
                    //   icon: Icon(Icons.settings),
                    //   label: 'Settings',
                    // ),
                  ],
                  currentIndex: selectedIndex,
                  onTap: ((value) {
                    setState(() {
                      if (selectedIndex == 0 && value == 0) {
                        scaffoldKey.currentState!.openDrawer();
                        return;
                      }
                      selectedIndex = value;
                    });
                  }),
                )),
        drawer: Drawer(
          child: SafeArea(
            right: true,
            child: Center(child: NavigationDrawer()),
          ),
        ),
      ),
    );
    return scaffold;
  }
}
