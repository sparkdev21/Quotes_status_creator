import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../AdHelpers.dart';

final bannerAdP = Provider.autoDispose((ref) => BannerProvider());

final bannerWidget = Provider.autoDispose<Widget>((ref) {
  final ad = ref.watch(bannerAdP);
  ref.onDispose(() {
    debugPrint("Banner provider Disposed 2");
  });
  return ad.getBannerAd();
});

class BannerProviderStateful extends StatefulWidget {
  const BannerProviderStateful({super.key});

  @override
  State<BannerProviderStateful> createState() => _BannerProviderStatefulState();
}

class _BannerProviderStatefulState extends State<BannerProviderStateful> {
  late BannerAd _bannerAd;
  bool _bannerReady = false;

  @override
  void dispose() {
    _bannerAd.dispose();
    debugPrint("Adbanner Admob Widget is Disposed");
    super.dispose();
  }

  @override
  void initState() {
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
          ad.dispose();
        },
      ),
    );
    _bannerAd.load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: AdWidget(ad: _bannerAd),
    );
  }
}

class BannerProvider {
  getBannerAd() {
    return BannerProviderStateful();
  }
}
