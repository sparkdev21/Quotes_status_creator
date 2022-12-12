import 'package:quotes_status_creator/utils/PageTrasition.dart';
import 'package:quotes_status_creator/views/Editor/SingleEditor.dart';
import 'package:social_share/social_share.dart';

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
  StoreQuotes sq = StoreQuotes();
  // Delete info from people box
  _deleteInfo(int index) {
    contactBox.deleteAt(index);

    print('Item deleted from box at index: $index');
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Get reference to an already opened box
    category = widget.category;
    contactBox = Hive.box(sq.catBoxName());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Favourites '),
          centerTitle: true,
        ),
        body: ValueListenableBuilder(
          valueListenable: contactBox.listenable(),
          builder: (context, Box box, widget) {
            if (box.isEmpty) {
              return const Center(
                child: Text('Empty'),
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
                                            SocialShare.shareOptions(
                                                personData.quote),
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

class TabLayoutExample extends StatefulWidget {
  final ValueListenableBuilder<Box> valueListenableBuilder;
  TabLayoutExample(this.valueListenableBuilder);

  @override
  State<StatefulWidget> createState() {
    return _TabLayoutExampleState();
  }
}

class _TabLayoutExampleState extends State<TabLayoutExample>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late ValueListenableBuilder<Box> valueListenableBuilder;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
    _tabController.animateTo(2);
    valueListenableBuilder = widget.valueListenableBuilder;
  }

  static const List<Tab> _tabs = [
    const Tab(icon: Icon(Icons.looks_two), text: 'Tab one'),
    const Tab(icon: Icon(Icons.looks_two), text: 'Tab Two'),
    const Tab(icon: Icon(Icons.looks_3), text: 'Tab Three'),
    const Tab(icon: Icon(Icons.looks_4), text: 'Tab Four'),
    const Tab(icon: Icon(Icons.looks_5), text: 'Tab Five'),
    const Tab(icon: Icon(Icons.looks_6), text: 'Tab Six'),
  ];

  static List<Widget> _views = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 6,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey,
              labelStyle: const TextStyle(fontWeight: FontWeight.bold),
              unselectedLabelStyle:
                  const TextStyle(fontStyle: FontStyle.italic),
              overlayColor:
                  MaterialStateColor.resolveWith((Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) {
                  return Colors.blue;
                }
                if (states.contains(MaterialState.focused)) {
                  return Colors.orange;
                } else if (states.contains(MaterialState.hovered)) {
                  return Colors.pinkAccent;
                }

                return Colors.transparent;
              }),
              indicatorWeight: 10,
              indicatorColor: Colors.red,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorPadding: const EdgeInsets.all(5),
              indicator: BoxDecoration(
                border: Border.all(color: Colors.red),
                borderRadius: BorderRadius.circular(10),
                color: Colors.pinkAccent,
              ),
              isScrollable: true,
              physics: BouncingScrollPhysics(),
              onTap: (int index) {
                print('Tab $index is tapped');
              },
              enableFeedback: true,
              // Uncomment the line below and remove DefaultTabController if you want to use a custom TabController
              // controller: _tabController,
              tabs: _tabs,
            ),
            title: const Text('Woolha.com Flutter Tutorial'),
            backgroundColor: Colors.teal,
          ),
          body: TabBarView(
            physics: BouncingScrollPhysics(),
            // Uncomment the line below and remove DefaultTabController if you want to use a custom TabController
            // controller: _tabController,
            children: [
              valueListenableBuilder,
              const Center(child: const Text('Content of Tab Two')),
              const Center(child: const Text('Content of Tab Three')),
              const Center(child: const Text('Content of Tab Four')),
              const Center(child: const Text('Content of Tab Five')),
              const Center(child: const Text('Content of Tab Six')),
            ],
          ),
        ),
      ),
    );
  }
}
