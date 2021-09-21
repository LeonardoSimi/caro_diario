import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

import '../widgets/diary_page.dart';
import '../widgets/diary_list.dart';
import '../widgets/bottom_nav_bar.dart';
import './page_details_screen.dart';
import './all_diary_screen.dart';
import './settings_screen.dart';

class MainDiaryScreen extends StatelessWidget {
  static const routeName = '/main-diary-screen';

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          'Caro diario',
          style: Theme.of(context).textTheme.headline1,
              textAlign: TextAlign.center,
        )),
        elevation: 0,
        backgroundColor: null,
        foregroundColor: null,
      ),
      bottomNavigationBar: BottomNavBar(),
      body: FutureBuilder(
          future:
              Provider.of<DiaryList>(context, listen: false).fetchAndSetPages(),
          builder: (ctx, snapshot) => Consumer<DiaryList>(
              child: Center(
                child: const Text('Start writing about your story.'),
              ),
              builder: (ctx, diaryList, ch) => diaryList.pages.length <= 0
                  ? ch!
                  : Column(children: [
                      Expanded(
                        flex: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'home',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              style: ButtonStyle(
                                  splashFactory: NoSplash.splashFactory),
                            ),
                            Spacer(),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, AllDiaryScreen.routeName);
                                },
                                child: Text(
                                  'diary',
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                style: ButtonStyle(
                                    splashFactory: NoSplash.splashFactory)),
                            Spacer(),
                            TextButton(
                                onPressed: () {
                                 AdaptiveTheme.of(context).toggleThemeMode();
                                },
                                child: Text(
                                  'settings',
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                style: ButtonStyle(
                                    splashFactory: NoSplash.splashFactory)),
                          ],
                        ),
                      ),
                      Padding(padding: EdgeInsets.symmetric(vertical: 7)),
                      cardSwiper(diaryList.pages.length, diaryList),
                      Padding(padding: EdgeInsets.symmetric(vertical: 15)),
                      Container(
                        height: 65,
                        width: width - 50,
                        child: Column(
                          children: [
                            Text(
                              'YOUR DIARY IS ' +
                                  diaryList.pages.length.toString() +
                                  ' PAGES LONG',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Padding(padding: EdgeInsets.symmetric(vertical: 4)),
                            Text('stats',
                                style: Theme.of(context).textTheme.subtitle1),
                          ],
                        ),
                      )
                    ]))),
    );
  }

  Widget cardSwiper(int pagesLength, DiaryList dList) {
    return Swiper(
      itemBuilder: (BuildContext context, int i) {
        return Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            decoration: BoxDecoration(color: Colors.white),
            child: Container(
              height: 250,
              width: 250,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PageDetailsScreen(
                                title: dList.pages[i].title!,
                                body: dList.pages[i].pageBody!,
                                date: dList.pages[i].dateTime!,
                              )));
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1),
                      borderRadius: BorderRadius.circular(7)),
                  // child: ListTile(
                  //     title: Text(dList.pages[i].title!, style: Theme.of(context).textTheme.bodyText1, overflow: TextOverflow.ellipsis,),
                  //     subtitle: Text(dList.pages[i].pageBody!, style: Theme.of(context).textTheme.bodyText1, overflow: TextOverflow.ellipsis, maxLines: 12,),
                  //     trailing: Text(
                  //       dList.pages[i].dateTime!,
                  //       style: TextStyle(color: Colors.grey),
                  //     ),
                  //   ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                          Align(alignment: Alignment.topCenter ,child: Text(dList.pages[i].title!, style: Theme.of(context).textTheme.bodyText2, overflow: TextOverflow.ellipsis,)),
                          Align(alignment: Alignment.topRight ,child: Text( dList.pages[i].dateTime!, style: TextStyle(color: Colors.grey, fontSize: 14),)),
                        Padding(padding: EdgeInsets.only(bottom: 2)),
                        Text(
                          dList.pages[i].pageBody!,
                          style: Theme.of(context).textTheme.bodyText1,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
      },
      itemCount: pagesLength,
      itemWidth: 400,
      itemHeight: 400,
      layout: SwiperLayout.TINDER,
    );
  }
}
