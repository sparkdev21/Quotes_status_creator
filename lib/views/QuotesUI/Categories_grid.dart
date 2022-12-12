import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:quotes_status_creator/models/love_quotes_english.dart';
import 'package:quotes_status_creator/views/Editor/SingleEditor.dart';

class CategoryGrid extends StatelessWidget {
  final String category;
  final List<QuotesModel> quotes;
  const CategoryGrid({Key? key, required this.category, required this.quotes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      itemCount: quotes.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                child: ShaderMask(
                  shaderCallback: (bounds) => RadialGradient(
                    center: Alignment.topLeft,
                    radius: 1.0,
                    colors: <Color>[
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.secondary,
                    ],
                    tileMode: TileMode.mirror,
                  ).createShader(bounds),
                  child: CachedNetworkImage(
                    placeholder: ((context, url) =>
                        Center(child: CircularProgressIndicator.adaptive())),
                    imageUrl: quotes[index].image!,
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
                        child: Text(quotes[index].content!.length.toString())),
                  )),
              Positioned(
                bottom: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    category,
                    style: labelStyle,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

const List<String> imageList = [
  'https://cdn.pixabay.com/photo/2019/03/15/09/49/girl-4056684_960_720.jpg',
  'https://cdn.pixabay.com/photo/2020/12/15/16/25/clock-5834193__340.jpg',
  'https://cdn.pixabay.com/photo/2020/09/18/19/31/laptop-5582775_960_720.jpg',
  'https://media.istockphoto.com/photos/woman-kayaking-in-fjord-in-norway-picture-id1059380230?b=1&k=6&m=1059380230&s=170667a&w=0&h=kA_A_XrhZJjw2bo5jIJ7089-VktFK0h0I4OWDqaac0c=',
  'https://cdn.pixabay.com/photo/2019/11/05/00/53/cellular-4602489_960_720.jpg',
  'https://cdn.pixabay.com/photo/2017/02/12/10/29/christmas-2059698_960_720.jpg',
  'https://cdn.pixabay.com/photo/2020/01/29/17/09/snowboard-4803050_960_720.jpg',
  'https://cdn.pixabay.com/photo/2020/02/06/20/01/university-library-4825366_960_720.jpg',
  'https://cdn.pixabay.com/photo/2020/11/22/17/28/cat-5767334_960_720.jpg',
  'https://cdn.pixabay.com/photo/2020/12/13/16/22/snow-5828736_960_720.jpg',
  'https://cdn.pixabay.com/photo/2020/12/09/09/27/women-5816861_960_720.jpg',
];
