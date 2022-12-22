import 'package:auto_size_text/auto_size_text.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quotes_status_creator/Monetization/Banners/small_banner.dart';
import 'package:quotes_status_creator/Monetization/NativeAds/native_banner.dart';

import '../../Monetization/AdmobHelper/AdmobHelper.dart';
import '/models/HiveModel/hive_quote_data_model.dart';
import '/services/store_quotes.dart';
import '/views/Editor/SingleEditor.dart';
import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:social_share/social_share.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({
    Key? key,
  }) : super(key: key);

  @override
  _FavouritePageState createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  late final Box contactBox;
  StoreQuotes sq = StoreQuotes();
  AdmobHelper admobHelper = new AdmobHelper();

  // Delete info from people box
  _deleteInfo(int index) {
    contactBox.deleteAt(index);
    admobHelper.decideIntersialAd(ActionAds.counterShow);
    print('Item deleted from box at index: $index');
  }

  _sharemsg(msg) {
    SocialShare.shareOptions(msg);
    admobHelper.decideIntersialAd(ActionAds.counterShow);
  }

  @override
  void dispose() {
    Fluttertoast.showToast(msg: "dispoded");
    debugPrint("dispded");
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    admobHelper.createIntersialad();
    contactBox = Hive.box(sq.catBoxName());
  }

  @override
  Widget build(BuildContext context) {
    var valueListenableBuilder = ValueListenableBuilder(
      valueListenable: contactBox.listenable(),
      builder: (context, Box box, widget) {
        if (box.isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const NativeBanner(),
              Text('Empty'),
            ],
          );
        } else {
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              var currentBox = box;
              HiveQuoteDataModel personData = currentBox.getAt(index)!;

              return InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(20),
                    elevation: 7,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(8),
                      style: ListTileStyle.list,
                      minVerticalPadding: 6,
                      title: AutoSizeText(
                        personData.quote,
                        textAlign: TextAlign.center,
                      ),
                      subtitle: Column(
                        children: [
                          const Divider(
                            color: Colors.white60,
                          ),
                          SizedBox(
                            height: 30,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                IconButton(
                                  onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SimpleEditorPage(
                                        quote: personData.quote,
                                        title: 'Editor',
                                      ),
                                    ),
                                    // PageTransition(
                                    //     child: SimpleEditorPage(
                                    //       quote: personData.quote,
                                    //       title: 'Editor',
                                    //     ),
                                    //     type: PageTransitionType
                                    //         .leftToRightWithFade)
                                  ),
                                  icon: Icon(
                                    Icons.edit,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () => _sharemsg(personData.quote),
                                  icon: Icon(
                                    Icons.share,
                                    color: Colors.green.shade400,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () => _deleteInfo(index),
                                  icon: Icon(
                                    Icons.delete,
                                    color: Color.fromARGB(255, 240, 110, 100),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favouritesd'),
        centerTitle: true,
      ),
      body: valueListenableBuilder,
      bottomNavigationBar: BannerSmall(),
    );
  }
}
