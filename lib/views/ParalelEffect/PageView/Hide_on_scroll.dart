import 'package:quotes_status_creator/views/widgets/SettingsPAge.dart';

import '../../../Constants/Custompath.dart';
import '../../../Controllers/OfflineHiveDataControllers.dart';
import '../../../Controllers/QuotesController.dart';
import '../../../Network/FirebaseData.dart';
import '../../../utils/PageTrasition.dart';
import '../../Editor/SingleEditor.dart';
import '../../QuotesUI/TinderSwipe copy 2.dart';
import '../../widgets/FavouritePage.dart';
import '/views/QuotesUI/Dashboard.dart';
import '/views/QuotesUI/UserQuotesPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../widgets/Sidebar.dart';
import '../parallelx_effect.dart';

class HideOnScroll extends StatefulWidget {
  const HideOnScroll({Key? key}) : super(key: key);

  @override
  _HideOnScrollState createState() => _HideOnScrollState();
}

class _HideOnScrollState extends State<HideOnScroll>
    with SingleTickerProviderStateMixin {
  int selectedIndex = 0;
  late AnimationController animationController;
  late List<Widget> _pages;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  // void _onItemTapped(int index, BuildContext ctx) {
  //   setState(() {
  //     if (index == 0) {
  //       Scaffold.of(ctx).openDrawer();
  //       return;
  //     }
  //     _selectedIndex = index;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    _pages = <Widget>[
      // CallsPage(
      //   isHideBottomNavBar: (isHideBottomNavBar) {
      //     isHideBottomNavBar
      //         ? animationController.forward()
      //         : animationController.reverse();
      //   },
      // ),
      // Dashboard(isHideBottomNavBar: (isHideBottomNavBar)
      //       ? animationController.forward()
      //       : animationController.reverse();)
      // PostHiveData(isHideBottomNavBar: (isHideBottomNavBar) {
      //   isHideBottomNavBar
      //       ? animationController.forward()
      //       : animationController.reverse();
      // }),

      MainDashBoard(isHideBottomNavBar: (isHideBottomNavBar) {
        isHideBottomNavBar
            ? animationController.forward()
            : animationController.reverse();
      }),
      CategoriesParallax(isHideBottomNavBar: (isHideBottomNavBar) {
        isHideBottomNavBar
            ? animationController.forward()
            : animationController.reverse();
      }),
      UserQuotesBlogPage(
        isHideBottomNavBar: (isHideBottomNavBar) {
          isHideBottomNavBar
              ? animationController.forward()
              : animationController.reverse();
        },
      ),
      SettingsUI()
      // SubmitPage(),
      // InnerSwiper(),
      // CategoryGrid()
      // FlowBack()
    ];
  }

  @override
  void dispose() {
    // ...
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      key: scaffoldKey,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: Material(child: Clipman())));
              },
              icon: Icon(Icons.download)),
          IconButton(
              onPressed: () async {
                OfflineHiveDataController().clearAll();
                QuotesController().clearAll();
              },
              icon: Icon(Icons.cabin)),
          IconButton(
              onPressed: () async {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: FireBaseData()));
              },
              icon: Icon(Icons.format_quote_sharp)),
          IconButton(
              onPressed: () async {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: InnerSwiper("dm", [])));
              },
              icon: Icon(Icons.near_me)),
          IconButton(
              onPressed: () async {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: FavouritePage()));
              },
              icon: Icon(Icons.format_quote_sharp))
        ],
        title: Text("Home"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 50,
              width: double.infinity,
              color: Colors.amberAccent,
              child: Center(
                child: Text(
                  "Ads",
                  textAlign: TextAlign.center,
                  style: labelStyle,
                ),
              ),
            ),
            Expanded(
              child: _pages.elementAt(selectedIndex),
            ),
          ],
        ),
      ),
      // body: IndexedStack(
      //   children: _pages,
      //   index: _selectedIndex,
      // ),
      bottomNavigationBar: SizeTransition(
          sizeFactor: animationController,
          axisAlignment: -1.0,
          child: BottomNavigationBar(
            selectedItemColor: Colors.blue,
            backgroundColor: Colors.amberAccent,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(selectedIndex == 0 ? Icons.menu : Icons.home),
                label: selectedIndex == 0 ? "Menu" : "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.camera),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.local_fire_department_rounded),
                label: 'User Quotes',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
              // BottomNavigationBarItem(
              //   icon: Icon(Icons.settings),
              //   label: 'Settings',
              // ),
              // BottomNavigationBarItem(
              //   icon: Icon(Icons.settings),
              //   label: 'Settings',
              // ),
            ],
            currentIndex: selectedIndex,
            onTap: ((value) {
              setState(() {
                if (selectedIndex == 0 && value == 0) {
                  scaffoldKey.currentState!.openDrawer();
                  return;
                }
                selectedIndex = value;
              });
            }),
          )),
      drawer: Drawer(
        child: SafeArea(
          right: true,
          child: Center(child: NavigationDrawer()),
        ),
      ),
    );
    return scaffold;

    Column(children: [
      Expanded(child: scaffold),
      Container(
        color: Colors.red,
        height: 50,
      )
    ]);
  }
}

class Dashboard extends StatelessWidget {
  final Function(bool) isHideBottomNavBar;

  Dashboard({Key? key, required this.isHideBottomNavBar}) : super(key: key);
  final items = List<String>.generate(10000, (i) => "Call $i");

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification.depth == 0) {
      if (notification is UserScrollNotification) {
        final UserScrollNotification userScroll = notification;
        switch (userScroll.direction) {
          case ScrollDirection.forward:
            isHideBottomNavBar(true);
            break;
          case ScrollDirection.reverse:
            isHideBottomNavBar(false);
            break;
          case ScrollDirection.idle:
            break;
        }
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('${items[index]}'),
          );
        },
      ),
    );
  }
}

class CallsPage extends StatelessWidget {
  CallsPage({required this.isHideBottomNavBar});
  final Function(bool) isHideBottomNavBar;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TabBar(
                tabs: [
                  Tab(
                    text: 'Incoming',
                  ),
                  Tab(
                    text: 'Outgoing',
                  ),
                  Tab(
                    text: 'Missed',
                  ),
                ],
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            IncomingPage(),
            OutgoingPage(
              isHideBottomNavBar: (value) {
                isHideBottomNavBar(value);
              },
            ),
            Icon(Icons.call_missed_outgoing, size: 350),
          ],
        ),
      ),
    );
  }
}

class IncomingPage extends StatefulWidget {
  @override
  _IncomingPageState createState() => _IncomingPageState();
}

class _IncomingPageState extends State<IncomingPage>
    with AutomaticKeepAliveClientMixin<IncomingPage> {
  int count = 10;

  void clear() {
    setState(() {
      count = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.call_received, size: 350),
              Text('Total incoming calls: $count',
                  style: TextStyle(fontSize: 30)),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: clear,
          child: Icon(Icons.clear_all),
        ));
  }

  @override
  bool get wantKeepAlive => true;
}

class OutgoingPage extends StatefulWidget {
  final Function(bool) isHideBottomNavBar;

  OutgoingPage({required this.isHideBottomNavBar});

  @override
  _OutgoingPageState createState() => _OutgoingPageState();
}

class _OutgoingPageState extends State<OutgoingPage>
    with AutomaticKeepAliveClientMixin<OutgoingPage> {
  final items = List<String>.generate(10000, (i) => "Call $i");

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification.depth == 0) {
      if (notification is UserScrollNotification) {
        final UserScrollNotification userScroll = notification;
        switch (userScroll.direction) {
          case ScrollDirection.forward:
            widget.isHideBottomNavBar(true);
            break;
          case ScrollDirection.reverse:
            widget.isHideBottomNavBar(false);
            break;
          case ScrollDirection.idle:
            break;
        }
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: Scaffold(
        body: Center(
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('${items[index]}'),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
