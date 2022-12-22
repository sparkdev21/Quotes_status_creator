import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../AdHelpers.dart';

class DynamicBanner extends StatefulWidget {
  final AdSize adsize;
  const DynamicBanner({Key? key, required this.adsize}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DynamicBannerState();
  }
}

class _DynamicBannerState extends State<DynamicBanner> {
  late BannerAd _bannerAd;
  bool _bannerReady = false;

  @override
  void didChangeDependencies() {
    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerGoogleAdmobOnlyAdUnitId,
      request: const AdRequest(),
      size: widget.adsize,
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
    Fluttertoast.showToast(msg: "disposed SatefulBanner");
    _bannerAd.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
