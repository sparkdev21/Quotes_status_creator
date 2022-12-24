import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quotes_status_creator/Network/Api/Dio/dio_api.dart';
import 'package:quotes_status_creator/models/SettingsModel.dart';
import 'package:quotes_status_creator/repositories/Blog/helper.dart';

import '../../Constants/keys.dart';
import '../../Controllers/OfflineHiveDataControllers.dart';
import '../../providers/SettingsProvider.dart';

final settingsRepositoryProvider =
    Provider.autoDispose((ref) => AppSettingsRepository());

final settingsDataProvider = FutureProvider.autoDispose<void>((ref) async {
  // access the provider above
  final repository = ref.watch(settingsRepositoryProvider);

  // use it to return a Future
  final datas = repository.fetchPosts();

  try {
    await datas.then((value) {
      print("settings :repository called");

      ref.read(settingsProvider.notifier).setSettings(value);
    });
  } catch (e) {
    print("settings :Error Data Fetching from Internet ");
  }
});

class AppSettingsRepository {
  Future<SettingsModels> fetchPosts() async {
    SettingsModels results = SettingsModels();

    final QuoteAPI http = QuoteAPI();
    OfflineHiveDataController quoteHiveController = OfflineHiveDataController();
    String url =
        'https://www.googleapis.com/blogger/v3/blogs/$blogId/pages/$settingsPAgeId?key=$apiKey&fields=content';

    offlineFetch() {
      // final postList = PostModel.fromJson(offlineBloGdata);
      print("settings Offline fetch settings called");

      results = SettingsModels.fromJson(SettingJSon);

      print("Offline Data code Exceuted");
      Fluttertoast.showToast(msg: results.adsNetwork.toString());
      print(results);
      return results;
    }

    try {
      if (await quoteHiveController.retriveSettingsData() != null) {
        Map<String, dynamic> jsonParsed = json
            .decode(await quoteHiveController.retriveSettingsData() as String);
        print("hive settings parsed: $jsonParsed");
        results = SettingsModels.fromJson(jsonParsed);

        Fluttertoast.showToast(msg: "Fetched from hive settings");

        return results;
      }
    } catch (e) {
      results = await http.getSettings(url);
      showToast(debug, "Fetched from Internet");
      debugPrint("settings online");
      return results;
    }

    return offlineFetch();

    // return offlineFetch();
  }
}

const SettingJSon = {
  "AdsNetwork": "Mediation",
  "fbAds": {
    "default": "no",
    "banner": "id",
    "intersstial": "id",
    "native_banner": "id",
    "medium_rectangle": "id"
  }
};
