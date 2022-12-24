import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../AdHelpers.dart';

class NativeBannerFeeds extends StatefulWidget {
  const NativeBannerFeeds({super.key});

  @override
  State<NativeBannerFeeds> createState() => _NativeBannerFeedsState();
}

class _NativeBannerFeedsState extends State<NativeBannerFeeds>
    with AutomaticKeepAliveClientMixin {
  late NativeAd nativeAd;
  bool isloaded = false;

  @override
  void dispose() {
    nativeAd.dispose();
    print('Ad native .disposed');
    super.dispose();
  }

  @override
  void initState() {
    nativeAd = NativeAd(
      adUnitId: AdHelper.nativeGoogleTestAdUnitId,
      factoryId: 'listTile',
      request: AdRequest(),
      listener: NativeAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (Ad ad) {
          isloaded = true;
          setState(() {});
          print('Ad loaded.native');
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          // Dispose the ad here to free resources.
          ad.dispose();
          print('Ad failed to load:native $error');
        },
        // Called when an ad opens an overlay that covers the screen.
        onAdOpened: (Ad ad) => print('Ad opened.'),
        // Called when an ad removes an overlay that covers the screen.
        onAdClosed: (Ad ad) => print('Ad closed.'),
        // Called when an impression occurs on the ad.
        onAdImpression: (Ad ad) => print('Ad impression. native'),
        // Called when a click is recorded for a NativeAd.
        onAdClicked: (ad) => print('Ad clicked.native'),
      ),
    )..load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return isloaded
        ? SizedBox(
            height: 50,
            child: AdWidget(ad: nativeAd),
          )
        : SizedBox.shrink();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
