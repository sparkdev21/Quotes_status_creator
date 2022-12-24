// To parse this JSON data, do
//
//     final settingModel = settingModelFromJson(jsonString);

import 'dart:convert';

class SettingsModels {
  String? adsNetwork;
  FbAds? fbAds;

  SettingsModels({this.adsNetwork, this.fbAds});

  SettingsModels.fromJson(Map<String, dynamic> json) {
    adsNetwork = json['AdsNetwork'];
    fbAds = json['fbAds'] != null ? new FbAds.fromJson(json['fbAds']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AdsNetwork'] = this.adsNetwork;
    if (this.fbAds != null) {
      data['fbAds'] = this.fbAds!.toJson();
    }
    return data;
  }
}

class FbAds {
  String? defaultAds;
  String? banner;
  String? intersstial;
  String? nativeBanner;
  String? mediumRectangle;

  FbAds(
      {this.defaultAds,
      this.banner,
      this.intersstial,
      this.nativeBanner,
      this.mediumRectangle});

  FbAds.fromJson(Map<String, dynamic> json) {
    defaultAds = json['defaultAds'];
    banner = json['banner'];
    intersstial = json['intersstial'];
    nativeBanner = json['native_banner'];
    mediumRectangle = json['medium_rectangle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['defaultAds'] = this.defaultAds;
    data['banner'] = this.banner;
    data['intersstial'] = this.intersstial;
    data['native_banner'] = this.nativeBanner;
    data['medium_rectangle'] = this.mediumRectangle;
    return data;
  }
}
