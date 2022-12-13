import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../AdHelpers.dart';

class BannerSmallDashboard extends StatefulWidget {
  const BannerSmallDashboard({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BannerSmallDashboardState();
  }
}

class _BannerSmallDashboardState extends State<BannerSmallDashboard>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  late BannerAd _bannerAd;
  bool _bannerReady = false;

  @override
  void didChangeDependencies() {
    _bannerAd = BannerAd(
      adUnitId: AdHelper.dashBannerAdUnitId,
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
          ad.dispose();
        },
      ),
    );
    _bannerAd.load();

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint("Adbanner Widget is Disposed:SatefulBanner");
    _bannerAd.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    debugPrint("Adbanner Widget is building:SMBANNER2");

    return _bannerReady
        ? SizedBox(
            width: _bannerAd.size.width.toDouble(),
            height: _bannerAd.size.height.toDouble(),
            child: AdWidget(ad: _bannerAd),
          )
        : const SizedBox.shrink();
  }
}
