import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../AdHelpers.dart';

class BannerMediumRectangleFeeds extends StatefulWidget {
  const BannerMediumRectangleFeeds({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BannerMediumRectangleFeedsState();
  }
}

class _BannerMediumRectangleFeedsState
    extends State<BannerMediumRectangleFeeds>
    with AutomaticKeepAliveClientMixin {
  late BannerAd _bannerAd;
  bool _bannerReady = false;

  @override
  void didChangeDependencies() {
    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerGoogleAdmobOnlyAdUnitId,
      request: const AdRequest(),
      size: AdSize.mediumRectangle,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _bannerReady = true;
            debugPrint("BannerMedium is loading:SatefulBanner2");
          });
        },
        onAdImpression: (ad) {
          debugPrint("BannerMedium Showed :SatefulBanner $ad");
        },
        onAdFailedToLoad: (ad, err) {
          debugPrint("BannerMedium Ad Failed to load $err");
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
    debugPrint("BannerMedium  Widget is Disposed:Medium");
    _bannerAd.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    debugPrint("BannerMedium Adbanner Widget is building:Medium");

    return _bannerReady
        ? SizedBox(
            width: _bannerAd.size.width.toDouble(),
            height: _bannerAd.size.height.toDouble(),
            child: AdWidget(ad: _bannerAd),
          )
        : const SizedBox.shrink();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
