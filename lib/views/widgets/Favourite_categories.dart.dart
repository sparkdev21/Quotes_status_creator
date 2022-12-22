import 'package:quotes_status_creator/Monetization/Banners/small_banner.dart';
import 'package:quotes_status_creator/Monetization/NativeAds/native_banner.dart';
import 'package:quotes_status_creator/utils/PageTrasition.dart';
import 'package:quotes_status_creator/views/Editor/SingleEditor.dart';
import 'package:social_share/social_share.dart';

import '../../Monetization/AdmobHelper/AdmobHelper.dart';
import '/models/HiveModel/hive_quote_data_model.dart';
import '/services/store_quotes.dart';
import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';

class FavouriteCategoryPage extends StatefulWidget {
  final String category;
  const FavouriteCategoryPage({Key? key, required this.category})
      : super(key: key);

  @override
  _FavouriteCategoryPageState createState() => _FavouriteCategoryPageState();
}

class _FavouriteCategoryPageState extends State<FavouriteCategoryPage> {
  late final Box contactBox;
  late String category;
  AdmobHelper admobHelper = new AdmobHelper();
  StoreQuotes sq = StoreQuotes();
  // Delete info from people box
  _deleteInfo(int index) {
    contactBox.deleteAt(index);
    admobHelper.decideIntersialAd(ActionAds.twoClicks);
    print('Item deleted from box at index: $index');
  }

  _sharemsg(msg) {
    SocialShare.shareOptions(msg);
    admobHelper.decideIntersialAd(
      ActionAds.counterShow,
    );
  }

  @override
  void dispose() {
    admobHelper.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    admobHelper.createIntersialad();
    // Get reference to an already opened box
    category = widget.category;
    contactBox = Hive.box(sq.catBoxName());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const BannerSmall(),
        appBar: AppBar(
          title: const Text('Favourites '),
          centerTitle: true,
        ),
        body: ValueListenableBuilder(
          valueListenable: contactBox.listenable(),
          builder: (context, Box box, widget) {
            if (box.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const NativeBanner(),
                  Text('No Favourites Added Yet!'),
                ],
              );
            } else {
              return ListView.builder(
                // separatorBuilder: (context, index) {
                //   if (index == 1) {
                //     return SizedBox.shrink();
                //   } else {
                //     return SizedBox(height: 8);
                //   }
                // },
                itemCount: box.length,
                itemBuilder: (context, index) {
                  var currentBox = box;
                  HiveQuoteDataModel personData = currentBox.getAt(index)!;
                  if (personData.category == category) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        child: Container(
                          padding: EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(color: Theme.of(context).cardColor)
                              ],
                              // gradient: LinearGradient(
                              //     colors: GradientColors.blackGray),
                              borderRadius: BorderRadius.circular(20)),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(8),
                            style: ListTileStyle.list,
                            minVerticalPadding: 6,
                            title: Text(
                              personData.quote,
                              textAlign: TextAlign.center,
                            ),
                            subtitle: Column(
                              children: [
                                Divider(),
                                SizedBox(
                                  height: 30,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      IconButton(
                                        onPressed: () => Navigator.push(
                                          context,
                                          PageTransition(
                                              child: SimpleEditorPage(
                                                  title: "title",
                                                  quote: personData.quote),
                                              type: PageTransitionType
                                                  .leftToRight),
                                        ),
                                        icon: Icon(Icons.edit,
                                            color: Color.fromRGBO(
                                                236, 204, 155, 1)),
                                      ),
                                      IconButton(
                                        onPressed: () =>
                                            _sharemsg(personData.quote),
                                        icon: const Icon(
                                          Icons.share,
                                          color: Color.fromARGB(
                                              255, 160, 207, 246),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () => _deleteInfo(index),
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Color.fromARGB(
                                              255, 222, 101, 113),
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
                  } else {
                    return SizedBox.shrink();
                  }
                },
              );
            }
          },
        ));
  }
}
