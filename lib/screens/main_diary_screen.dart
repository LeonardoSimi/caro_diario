import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

import '../widgets/diary_page.dart';
import '../widgets/diary_list.dart';
import './page_details_screen.dart';

class MainDiaryScreen extends StatefulWidget {
  static const routeName = '/main-diary-screen';

  @override
  _MainDiaryScreenState createState() => _MainDiaryScreenState();
}

class _MainDiaryScreenState extends State<MainDiaryScreen> {
  late bool isSwitched;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Caro diario',
          style: Theme.of(context).textTheme.headline1,
              textAlign: TextAlign.center,
        ),
        actions: [
          IconButton(onPressed: () => AdaptiveTheme.of(context).setLight(), icon: Icon(Icons.wb_sunny)),
          IconButton(onPressed: () => AdaptiveTheme.of(context).setDark(), icon: Icon(Icons.nightlight_round)),
/*          CupertinoSwitch(
            value: isSwitched,
            onChanged: (value) {
              setState(() {
                isSwitched = value;
                AdaptiveTheme.of(context).toggleThemeMode();
              });
            },
          ),*/
        ],
        elevation: 0,
        backgroundColor: null,
        foregroundColor: null,
      ),
      body: FutureBuilder(
          future:
              Provider.of<DiaryList>(context).fetchAndSetPages(),
          builder: (ctx, snapshot) => Consumer<DiaryList>(
              child: Stack(
                children: [
                  Center(
                  child: const Text('Start writing about your story.'),
                ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: FloatingActionButton(child: Icon(Icons.add_circle_outline_sharp, color: Colors.black,),
                        onPressed: () => Navigator.of(context).pushNamed(DiaryPage.routeName),
                        backgroundColor: Colors.white38,),
                    ),
                  ),
        ]
              ),
              builder: (ctx, diaryList, ch) => diaryList.pages.length <= 0
                  ? ch!
                  : Column(
                  children: [
                      Container(child: cardSwiper(diaryList.pages.length, diaryList)),
                      Padding(padding: const EdgeInsets.symmetric(vertical: 25)),
                      Container(
                        height: 110,
                        width: width - 50,
                        child: Column(
                          children: [
                            Text(
                              'YOUR DIARY IS ' +
                                  diaryList.pages.length.toString() +
                                  ' PAGES LONG',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Padding(padding: const EdgeInsets.only(bottom: 30)),
                            FloatingActionButton(child: Icon(Icons.add_circle_outline_sharp, color: Colors.black,),
                              onPressed: () => Navigator.of(context).pushNamed(DiaryPage.routeName),
                              backgroundColor: Colors.white38,),
                          ],
                        ),
                      )
                    ]))),
    );
  }
  Widget cardSwiper(int pagesLength, DiaryList dList) {
    return Swiper(
      itemBuilder: (BuildContext context, int i) {
        return GestureDetector(
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
                      side: BorderSide(width: 1, color: Colors.black12),
                      borderRadius: BorderRadius.circular(60)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                          Align(alignment: Alignment.topCenter ,child: Text(dList.pages[i].title!, style: Theme.of(context).textTheme.bodyText2, overflow: TextOverflow.ellipsis,)),
                          Align(alignment: Alignment.topRight ,child: Text( dList.pages[i].dateTime!, style: TextStyle(color: Colors.grey, fontSize: 14))),
                        Padding(padding: EdgeInsets.only(bottom: 2)),
                        Text(
                          dList.pages[i].pageBody!,
                          style: Theme.of(context).textTheme.bodyText1,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 4,
                        ),
                      ],
                    ),
                  ),
                ),
              );
      },
      itemCount: pagesLength,
      itemWidth: 400,
      itemHeight: 400,
      layout: SwiperLayout.TINDER,
    );
  }
}
