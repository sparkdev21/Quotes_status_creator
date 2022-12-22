import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quotes_status_creator/utils/PageTrasition.dart';
import 'package:quotes_status_creator/views/Category_quote_detail_page.dart';
import 'package:quotes_status_creator/views/QuotesUI/Categories_grid.dart';

import './providers/QuotesUINotifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'models/love_quotes_english.dart';
import 'models/post_list_model.dart';
import 'repositories/Blog/blog_fetch_repository.dart';
import 'package:flutter/src/widgets/image.dart' as img;

final blogRepositoryProvider = Provider.autoDispose((ref) => BlogRepository());

final blogProvider = FutureProvider.autoDispose<PostModel>((ref) {
  // access the provider above
  final repository = ref.watch(blogRepositoryProvider);
  // use it to return a Future
  return repository.fetchPosts();
});

final managedblogProvider = FutureProvider.autoDispose<PostModel>((ref) async {
  ref.onDispose(() {
    debugPrint("Disposed blog provider");
  });
  // access the provider above
  final repository = ref.watch(blogRepositoryProvider);
  // use it to return a Future
  final datas = repository.fetchPosts();

  List<List<QuotesModel>> quotesList = [];
  List<String> titles = [];
  await datas.then((quotes) {
    ref.read(mainQuotesProvider.notifier).setPostData(quotes);
    Fluttertoast.showToast(msg: quotes.toString());

    for (int i = 0; i < quotes.items!.length; i++) {
      print("GG:${quotes.items![i].title!}");
      print("GGi:${quotes.items!.length}");
      titles.add(quotes.items![i].title!);
      List gb = json.decode(quotes.items![i].content!) as List;

      print("GG:${gb.runtimeType}"); //returns List<dynamic>
      List<QuotesModel> imagesList =
          gb.map((e) => QuotesModel.fromJson(e)).toList();

      quotesList.add(imagesList);

      print("GG:${quotesList.length}");
    }

    ref.read(mainQuotesProvider.notifier).setMainQuotes(quotesList);
    ref.read(mainQuotesProvider.notifier).setQuotesCategories(titles);
    print("quotesList:Hello");
  }
      // return (quotesList.map((e)=>QuotesModel.fromJson(e).toList()));
      );

  return datas;
});

class PostHiveData extends ConsumerWidget {
  PostHiveData({Key? key}) : super(key: key);
  // bool _handleScrollNotification(ScrollNotification notification) {
  //   if (notification.depth == 0) {
  //     if (notification is UserScrollNotification) {
  //       final UserScrollNotification userScroll = notification;
  //       switch (userScroll.direction) {
  //         case ScrollDirection.forward:
  //           isHideBottomNavBar(true);
  //           break;
  //         case ScrollDirection.reverse:
  //           isHideBottomNavBar(false);
  //           break;
  //         case ScrollDirection.idle:
  //           break;
  //       }
  //     }
  //   }
  //   return false;
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(mainQuotesProvider);
    final cat = ref.watch(mainQuotesProvider.notifier).categories;
    final datas = ref.watch(mainQuotesProvider.notifier).mainQuotes;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: MasonryGridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          itemCount: cat.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final category = cat[index];
            final quotesList = datas[index];
            return GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  PageTransition(
                      child: CategoryQuoteDetailPage(1, category, quotesList),
                      type: PageTransitionType.rightToLeftWithFade)),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      child: ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          // radius: 1.0,
                          colors: [
                            Theme.of(context).colorScheme.primaryContainer,
                            Theme.of(context).colorScheme.onSecondaryContainer,
                          ],
                          tileMode: TileMode.mirror,
                        ).createShader(bounds),
                        child: CachedNetworkImage(
                          placeholder: ((context, url) => Center(
                              child: img.Image.asset(
                                  'assets/images/icon/icon_background.png'))),
                          imageUrl:
                              imageList[imageList.length < index ? 0 : index],
                          // imageUrl: quotesList[0].image!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16))),
                              child: Text(
                                quotesList[0].content!.length.toString(),
                                style: TextStyle(color: Colors.white),
                              )),
                        )),
                    Positioned(
                      bottom: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          category,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
