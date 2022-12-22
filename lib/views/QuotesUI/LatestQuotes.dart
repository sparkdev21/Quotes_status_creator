import 'dart:convert';

import '../../Monetization/Banners/small_banner.dart';
import '../../post_list_view_hive_data.dart';
import '/providers/QuotesUINotifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/love_quotes_english.dart';
import '../../models/post_list_model.dart';
import '../Category_quote_detail_page.dart';
import '../ParalelEffect/parallelx_effect.dart';
import 'Categories_grid.dart';
import 'FeaturedQuotes.dart';
import 'TrendingQuotes.dart';

class LatestQuotes extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PostModel datas = ref.watch(mainQuotesProvider.notifier).postData;
    return datas.items == null
        ? Center(
            child: Material(
                child: Stack(
              children: [
                SafeArea(
                    child: Align(
                        alignment: Alignment.topCenter,
                        child: LinearProgressIndicator())),
                Align(
                    alignment: Alignment.center,
                    child: Text("Please connect to the Internet")),
                Padding(
                  padding: const EdgeInsets.only(top: 100.0),
                  child: Center(
                    child: ElevatedButton(
                        onPressed: (() {
                          Navigator.pop(context);
                          ref.read(blogProvider);
                          ref.read(featuredQuotesProvider);

                          ref.read(trendingQuotesProvider);
                        }),
                        child: Text(
                          "Retry",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                )
              ],
            )),
          )
        : Scaffold(
            bottomNavigationBar: BannerSmall(),
            appBar: AppBar(
                centerTitle: true,
                title: const Text("Latest Categories",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                actions: []),
            body: Column(children: [
              // Row(
              //   children: [
              //     Padding(
              //         padding: EdgeInsets.only(top: 24, right: 24),
              //         child: TextButton(
              //             onPressed: () {
              //               Navigator.pop(context);
              //             },
              //             child: Icon(Icons.arrow_back_ios))),
              //     Padding(
              //       padding: EdgeInsets.only(top: 24),
              //       child: Align(
              //         alignment: Alignment.center,
              //         child: const Text("Latest Categories",
              //             textAlign: TextAlign.center,
              //             style: TextStyle(
              //                 fontSize: 24, fontWeight: FontWeight.bold)),
              //       ),
              //     ),
              //   ],
              // ),
              Flexible(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: datas.items!.length,
                    itemBuilder: (context, int i) {
                      PostModel posts = datas;
                      DateTime dt1 = DateTime.parse(posts.items![0].published!);
                      DateTime dt2 = DateTime.parse(posts.items![1].published!);
                      print("d1:$dt1:dt2:$dt2");

                      if (i < 5 && dt1.compareTo(dt2) > 0) {
                        List gb = json.decode(posts.items![i].content!);
                        var quotes =
                            gb.map((e) => new QuotesModel.fromJson(e)).toList();

                        return Stack(
                          children: [
                            LocationListItem(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CategoryQuoteDetailPage(
                                                  i,
                                                  posts.items![i].title!,
                                                  quotes)));
                                },
                                // imageUrl: quotes[0].image!,
                                imageUrl:
                                    imageList[imageList.length < i ? 0 : i],
                                name: datas.items![i].title!,
                                country: quotes[0].content!.length.toString()),
                            // Padding(
                            //   padding: const EdgeInsets.all(18.0),
                            //   child: Align(
                            //     alignment: Alignment.topLeft,
                            //     child: Banner(
                            //         message: "New",
                            //         location: BannerLocation.topStart),
                            //   ),
                            // ),
                          ],
                        );
                      }
                      return SizedBox.shrink();
                    }),
              ),
            ]),
          );
  }
}
