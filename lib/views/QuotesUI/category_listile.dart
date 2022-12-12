import '/models/love_quotes_english.dart';
import '/utils/PageTrasition.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gradient_colors/gradient_colors.dart';

import '../Category_quote_detail_page.dart';
import 'dart:math' as math;







class CategoryListTile extends StatelessWidget {
  final String category;
  final List<QuotesModel> quotes;
  const CategoryListTile(
      {super.key, required this.quotes, required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          PageTransition(
              child: CategoryQuoteDetailPage(1, category, quotes),
              type: PageTransitionType.values[math.Random().nextInt(10)])),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: LayoutBuilder(
          builder: (context, constraint) {
            return Card(
              elevation: 2.0,
              color: Colors.red,
              child: Container(
                width: constraint.maxWidth,
                height: 70,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(12),
                        topLeft: Radius.circular(22),
                        bottomLeft: Radius.circular(22),
                        topRight: Radius.circular(10)),
                    gradient: LinearGradient(colors: GradientColors.amour)),
                child: Row(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                              color: Colors.white24,
                              blurRadius: 2.0,
                              offset: Offset(
                                2,
                                1,
                              )),
                          BoxShadow(
                              color: Colors.green,
                              blurRadius: 2.0,
                              offset: Offset(
                                -3,
                                -2,
                              ))
                        ], borderRadius: BorderRadius.circular(5)),
                        child: CachedNetworkImage(
                          imageUrl: quotes[0].image!,
                          fit: BoxFit.cover,
                          width: 70,
                          height: 70,
                          placeholder: (context, url) =>
                              Image.asset('assets/image.jpg'),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 5, 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: constraint.maxWidth - 130,
                            child: Text(category,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontSize: 15)),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Container(
                            width: constraint.maxWidth - 130,
                            child: Row(
                              children: [
                                Container(
                                  color: Colors.transparent,
                                  padding: EdgeInsets.all(3),
                                  child: Row(
                                    children: [
                                      Text(
                                          '${quotes[0].content!.length.toString()}',
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13)),
                                      SizedBox(width: 2),
                                      Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: 15,
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(width: 5),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios)
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
