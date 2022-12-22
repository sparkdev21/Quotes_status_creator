package quotes.status.creator;


import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin;
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin.NativeAdFactory;

public class MainActivity extends FlutterActivity {
  @Override
  public void configureFlutterEngine(FlutterEngine flutterEngine) {
    super.configureFlutterEngine(flutterEngine);
    // final ListTileNativeAdFactory factory = new ListTileNativeAdFactory(getLayoutInflater());
    GoogleMobileAdsPlugin.registerNativeAdFactory(flutterEngine, "listTile", new ListTileNativeAdFactory(getContext()));
  }

  @Override
  public void cleanUpFlutterEngine(FlutterEngine flutterEngine) {
    GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "listTile");
  }
}
