import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:quotes_status_creator/Monetization/AdHelpers.dart';

enum ActionAds {
  directShow, //show on click
  counterShow, //show when count reached
  onNavigation, //when exit page
  twoClicks,
  twoClicksAction
}

enum IntersialType {
  video,
  image,
}

class AdmobHelper extends ChangeNotifier {
//show interestial after certain no events
  int _show_after_events = 4;
  get show_after_event => _show_after_events;
  set show_after_event(val) {
    _show_after_events = val;
    notifyListeners();
  }

  //favourite butto click
  int _show_after_clicks = 4;
  int _clickCounter = 0;
  get clickCounter => _clickCounter;
  changeClick() {
    _clickCounter += 1;
    print("adts:cc$_clickCounter");
    if (_clickCounter >= _show_after_clicks) {
      decideIntersialAd(ActionAds.directShow);
      _clickCounter = 0;
    }

    notifyListeners();
  }
  //

  int _rewardedPoint = 0;

  int getrewardpoint() => _rewardedPoint;

  static String get bannerUnit => 'ca-app-pub-3940256099942544/6300978111';

  InterstitialAd? _interstitialAd;

  RewardedAd? _rewardedAd;

  int num_of_attempt_load = 0;
  //adss shown

  int _adcounter = 0;
  get adcounter => _adcounter;
  set adcounter(value) {
    _adcounter = value;
    notifyListeners();
  }

  int interstial_shown = 0;

  get interstialshown => interstialshown;

  static BannerAd getBannerAd() {
    BannerAd bAd = new BannerAd(
        size: AdSize.fullBanner,
        adUnitId: AdHelper.bannerGoogleAdmobOnlyAdUnitId,
        listener: BannerAdListener(
            onAdClosed: (Ad ad) {
              print("Ad Closed");
            },
            onAdImpression: (ad) => debugPrint("Ad Impression"),
            onAdFailedToLoad: (Ad ad, LoadAdError error) {
              ad.dispose();
            },
            onAdLoaded: (Ad ad) {
              print('Ad Loaded');
            },
            onAdWillDismissScreen: (ad) => debugPrint("Ad dismissed screen"),
            onAdOpened: (Ad ad) {
              print('Ad opened');
            }),
        request: AdRequest());

    return bAd;
  }

  void decideIntersialAd(ActionAds type) {
    switch (type) {
      case ActionAds.directShow:
        if (_interstitialAd != null) {
          showInterad();
        } else {
          print("adts:CRETE$_interstitialAd");

          createIntersialad();
        }

        break;
      case ActionAds.counterShow:
        adcounter += 1;
        if (adcounter >= show_after_event) {
          adcounter = 0;
          if (_interstitialAd != null) {
            showInterad();
          } else {
            createIntersialad();
          }
        }
        break;
      case ActionAds.onNavigation:
        showInterad();

        break;
      case ActionAds.twoClicks:
        adcounter += 2;
        if (adcounter >= show_after_event) {
          adcounter = 0;
          if (_interstitialAd != null) {
            showInterad();
          } else {
            createIntersialad();
          }
        }
        break;
      case ActionAds.twoClicksAction:
        adcounter += 2;
        if (adcounter >= show_after_event) {
          adcounter = 0;
          if (_interstitialAd != null) {
            showInterad();
          } else {
            createIntersialad();
          }
        }
        break;
    }
  }

  void createIntersialad() {
    InterstitialAd.load(
        adUnitId: AdHelper.interstitialGoogleTestAdUnitId,
        request: AdRequest(),
        adLoadCallback:
            InterstitialAdLoadCallback(onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          num_of_attempt_load = 0;
        }, onAdFailedToLoad: (LoadAdError error) {
          num_of_attempt_load + 1;
          _interstitialAd = null;
        }));
  }

  void createImageIntersialad() {
    InterstitialAd.load(
        adUnitId: AdHelper.interstitialGoogleTestAdUnitId, //image interstial
        request: AdRequest(),
        adLoadCallback:
            InterstitialAdLoadCallback(onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          num_of_attempt_load = 0;
        }, onAdFailedToLoad: (LoadAdError error) {
          num_of_attempt_load + 1;
          _interstitialAd = null;
        }));
  }

  void showInterad() {
    if (_interstitialAd == null) {
      return;
    }

    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (InterstitialAd ad) {
      interstial_shown + 1;
      createIntersialad();
      print("ad onAdshowedFullscreen");
    }, onAdDismissedFullScreenContent: (InterstitialAd ad) {
      print("ad Disposed");
      ad.dispose();
    }, onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError aderror) {
      print('$ad OnAdFailed $aderror');
      ad.dispose();
      createIntersialad();
    });

    _interstitialAd!.show();

    _interstitialAd = null;
  }

  void showDownloadInterad(context) {
    if (_interstitialAd == null) {
      showDownloadedDialog(context);
      return;
    }

    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (InterstitialAd ad) {
      interstial_shown + 1;
      createIntersialad();
      print("ad onAdshowedFullscreen");
    }, onAdDismissedFullScreenContent: (InterstitialAd ad) {
      print("ad Disposed");
      showDownloadedDialog(context);
      ad.dispose();
    }, onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError aderror) {
      print('$ad OnAdFailed $aderror');
      ad.dispose();
      createIntersialad();
    });

    _interstitialAd!.show();

    _interstitialAd = null;
  }

  void showDownloadedDialog(context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          Future.delayed(Duration(seconds: 3))
              .then((value) => Navigator.pop(context));
          return AlertDialog(
            backgroundColor: Colors.green.shade100,
            content: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Successfully Downloaded and Saved in Gallery",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
            actions: [
              IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.done))
            ],
          );
        });

    // void loadRewardedAd() {
    //   RewardedAd.load(
    //       adUnitId: 'ca-app-pub-3940256099942544/5224354917',
    //       request: AdRequest(),
    //       rewardedAdLoadCallback:
    //           RewardedAdLoadCallback(onAdLoaded: (RewardedAd ad) {
    //         print("Ad loaded");
    //         this._rewardedAd = ad;
    //       }, onAdFailedToLoad: (LoadAdError error) {
    //         // loadRewardedAd();
    //       }));
    // }
  }
}
