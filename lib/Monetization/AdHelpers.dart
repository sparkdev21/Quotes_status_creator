import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-7153782539261935/7885209083';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get dashBannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-7153782539261935/4790607038';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get anchorBannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-7153782539261935/9130842148';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get imageAnchorBannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-7153782539261935/5331746678';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-7153782539261935/9513985527";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/4411468910";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get appOpenAdunitId {
    //in main dart file
    if (Platform.isAndroid) {
      return "ca-app-pub-7153782539261935/5076009072";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/5662855259";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get interstitialImageOnlyAdId {
    if (Platform.isAndroid) {
      return "ca-app-pub-7153782539261935/6887822189";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/4411468910";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get bannerGoogleAdmobOnlyAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/6300978111"; //only admob no medediation
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/6300978111"; //android kai ho
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get interstitialGoogleTestAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/1033173712";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/4411468910";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }
}
