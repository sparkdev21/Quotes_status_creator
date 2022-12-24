import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quotes_status_creator/models/SettingsModel.dart';

final settingsProvider = ChangeNotifierProvider<SettingNotifier>((ref) {
  return SettingNotifier();
});

class SettingNotifier extends ChangeNotifier {
  SettingsModels _settings = SettingsModels(
      adsNetwork: "admob",
      fbAds: FbAds(
          banner: '', intersstial: '', nativeBanner: '', mediumRectangle: ''));

  get settings => _settings;

  setSettings(SettingsModels value) {
    if (value.fbAds!.defaultAds == 'yes') {
      return;
    }
    _settings = value;
    notifyListeners();
  }
}
