import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'AdHelpers.dart';

class AdState {
  Future<InitializationStatus> initialization;
  AdState(this.initialization);

  initAds() {
    MobileAds.instance
        .updateRequestConfiguration(RequestConfiguration(testDeviceIds: [
      "49606f71-e1ec-4c3d-96a7-de6f43613933",
      "2f74d483-16d3-4e0a-9ff7-c9b36a06e82b",
      "5a229d62-59cd-4b53-b2a8-a17837fea867"
    ]));
    MobileAds.instance.initialize().then((initializationStatus) {
      initializationStatus.adapterStatuses.forEach((key, value) {
        debugPrint('Adapter status for $key: ${value.description}');
      });
    });
  }

  BannerAd getBannerAd() {
    return BannerAd(
      adUnitId: AdHelper.bannerGoogleAdmobOnlyAdUnitId,
      size: AdSize.fullBanner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          debugPrint("New banner ad loaded");
        },
        onAdClosed: (ad) {
          debugPrint("New banner ad closed $ad");
        },
        onAdImpression: (ad) {
          debugPrint("New banner ad Impression $ad");
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
          debugPrint("Ad error: $error");
        },
      ),
      // You can fire-and-forget the call to .load(),
      // it does not need to be awaited
    )..load();
  }

  BannerAd getBannerAd2() {
    return BannerAd(
      adUnitId: AdHelper.bannerGoogleAdmobOnlyAdUnitId,
      size: AdSize.fullBanner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          debugPrint("New banner ad2 loaded");
        },
        onAdClosed: (ad) {
          debugPrint("New banner ad2 closed $ad");
        },
        onAdImpression: (ad) {
          debugPrint("New banner ad2 Impression $ad");
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
          debugPrint("Ad error: $error");
        },
      ),
      // You can fire-and-forget the call to .load(),
      // it does not need to be awaited
    );
  }
}
