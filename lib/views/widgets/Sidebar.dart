import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quotes_status_creator/utils/PageTrasition.dart';
import 'package:quotes_status_creator/views/Editor/SingleEditor.dart';
import 'package:quotes_status_creator/views/ParalelEffect/PageView/Hide_on_scroll.dart';
import 'package:social_share/social_share.dart';

import '../../providers/ThemeProvider.dart';
import '../ParalelEffect/parallelx_effect.dart';
import '../SubmitQuotes/submit.dart';
import '/views/widgets/FavouritePage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:store_redirect/store_redirect.dart';

import 'about_us.dart';

// ignore: must_be_immutable
class NavigationDrawer extends ConsumerWidget {
  NavigationDrawer({Key? key}) : super(key: key);
  HideOnScroll hideOnScroll = HideOnScroll();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context),
            _buildMenuItems(context),
          ],
        ),
      ),
    );
  }
}

Widget _buildHeader(BuildContext context) {
  return Material(
    child: InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/');
      },
      child: Container(
        padding: EdgeInsets.only(
          top: 24 + MediaQuery.of(context).padding.top,
          bottom: 20,
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(200.0),
              child: Image.asset(
                'assets/images/icon/icon.png',
                height: 100,
                width: 100,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              'Quotes And Status Creator ',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const Divider(
              thickness: 1,
            )
            // Text(
            //   'Flutter Developer',
            //   style: TextStyle(
            //     fontSize: 16,
            //     color: Colors.grey,
            //   ),
            // ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildMenuItems(BuildContext context) {
  return Container(
      // color: Theme.of(context).colorScheme.secondaryContainer,
      // decoration: BoxDecoration(
      //   gradient: LinearGradient(
      //     begin: Alignment.topLeft,
      //     end: Alignment.bottomRight,
      //     tileMode: TileMode.decal,
      //     transform: GradientRotation(180),
      //     colors: GradientColors.rozenBerry,
      //   ),
      //   border: Border(
      //     top: BorderSide(
      //       color: Colors.grey,
      //       width: 1,
      //     ),
      //   ),
      // ),
      padding: const EdgeInsets.all(16),
      child: Wrap(runSpacing: 8, children: [
        ListTile(
          leading: const Icon(Icons.home_outlined),
          title: const Text('Home'),
          onTap: () {
            closeContext(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.format_quote_sharp),
          title: const Text('Categories'),
          onTap: () async {
            closeContext(context);

            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Scaffold(
                  appBar: AppBar(
                    title: Text('Categories'),
                    centerTitle: true,
                  ),
                  body: CategoriesParallax(isHideBottomNavBar: (bool) {
                    return false;
                  })),
            ));
          },
        ),
        // ListTile(
        //   leading: const Icon(Icons.format_quote_sharp),
        //   title: const Text('Submit Quotes'),
        //   onTap: () {
        //     Navigator.pop(context);
        //     // Navigator.of(context).push(MaterialPageRoute(
        //     //     builder: (context) => const DashainScreen(
        //     //           initialindex: 0,
        //     //           name: 'Tihar Wishes',
        //     //         )));
        //   },
        // ),
        ListTile(
          leading: const Icon(FontAwesomeIcons.penToSquare),
          title: const Text('Edit Quotes'),
          onTap: () {
            Navigator.pop(context);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SimpleEditorPage(
                      title: '',
                      quote: 'Create your own quotes',
                    )));
          },
        ),
        // ListTile(
        //   leading: const Icon(Icons.photo_library_outlined),
        //   title: const Text('Images'),
        //   onTap: () {
        //     Navigator.pop(context);
        //     // Navigator.of(context).push(MaterialPageRoute(
        //     //     builder: (context) => const ImageScreen(name: 'Images')));
        //   },
        // ),
        ListTile(
          leading: const Icon(Icons.favorite_border_outlined),
          title: const Text('Favourites'),
          onTap: () {
            Navigator.pop(context);
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const FavouritePage()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.upload_outlined),
          title: const Text('Submit Quotes'),
          onTap: () {
            Navigator.pop(context);
            Navigator.of(context).push(PageTransition(
              child: SubmitQuotesPage(title: "Feedback"),
              type: PageTransitionType.leftToRight,
            ));
          },
        ),
        const Divider(),

        Consumer(builder: (context, ref, _) {
          return ListTile(
            leading: ref.watch(themeProvider.notifier).darkTheme
                ? const Icon(Icons.light_mode_outlined)
                : const Icon(Icons.dark_mode_outlined),
            title: ref.watch(themeProvider.notifier).darkTheme
                ? const Text('Light Theme')
                : const Text('Dark Theme'),
            onTap: () {
              ref.watch(themeProvider.notifier).darkTheme =
                  !ref.watch(themeProvider.notifier).darkTheme;
              ref
                  .read(themeProvider.notifier)
                  .toggleTheme(ref.watch(themeProvider.notifier).darkTheme);
              Navigator.pop(context);

              // Navigator.of(context).push(MaterialPageRoute(
              //   builder: (context) => const FeedbackPage(title: "Feedback"),
              // ));
            },
          );
        }),
        ListTile(
          leading: const Icon(Icons.star_border_outlined),
          title: const Text('Rate this App'),
          onTap: () {
            StoreRedirect.redirect(
                androidAppId: "com.aoneapps1.DashainTiharWishes");
          },
        ),
        ListTile(
          leading: const Icon(Icons.share),
          title: const Text('Share'),
          onTap: () async {
            SocialShare.shareOptions("shareAppText");
            // await FirebaseAnalytics.instance
            //     .logEvent(name: "Share_App_from_menu");
          },
        ),
        ListTile(
          leading: const Icon(Icons.privacy_tip_outlined),
          title: const Text('Privacy Policy'),
          onTap: () {
            // launchUrl(Uri.parse(privacyPolicyUrl));
          },
        ),
        ListTile(
          leading: const Icon(Icons.info_outline),
          title: const Text('About us'),
          onTap: () {
            showDialog(context: context, builder: ((context) => AboutWidget()));

            // showDialog(
            //     context: context,
            //     builder: (BuildContext context) => AlertDialog(
            //           contentPadding: const EdgeInsets.only(top: 8, bottom: 2),
            //           content: Column(
            //             children: [
            //               // ContactUs(
            //               //   logo: 'assets/images/icon/icon.png',
            //               //   email: 'aoneapps1@gmail.com',
            //               //   companyName: 'AoneApps',
            //               //   applicationVersion: '1.2',
            //               //   dividerThickness: 2,
            //               //   website: 'https://aoneapps1.blogspot.com',
            //               //   tagLine: 'One tap to unlock your life 🚀',
            //               //   cardColor: Theme.of(context).colorScheme.tertiary,
            //               //   taglineColor: Theme.of(context)
            //               //       .colorScheme
            //               //       .onTertiaryContainer,
            //               //   companyColor: Theme.of(context).colorScheme.primary,
            //               //   textColor: Colors.black,
            //               // ),
            //               const SizedBox(
            //                 height: 8,
            //               ),
            //             ],
            //           ),
            //         ));
          },
        ),
      ]));
}

void closeContext(BuildContext context) async {
  Navigator.pop(context, true);
}
