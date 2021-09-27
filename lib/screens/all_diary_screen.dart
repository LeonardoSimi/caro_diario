import 'dart:io';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:path/path.dart';

import '../models/DPage.dart';
import '../widgets/diary_list.dart';

class AllDiaryScreen extends StatelessWidget {
  const AllDiaryScreen({Key? key}) : super(key: key);

  static const routeName = '/all_diary_screen';

  @override
  Widget build(BuildContext context) {
    final _controller =
        PageController(initialPage: 0, viewportFraction: 1, keepPage: true);
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Caro diario',
            style: Theme.of(context).textTheme.headline1,
            textAlign: TextAlign.center,
          ),
          elevation: 0,
          backgroundColor: null,
          foregroundColor: null,
        ),
        body: FutureBuilder(
          future:
              Provider.of<DiaryList>(context, listen: false).fetchAndSetPages(),
          builder: (ctx, snapshot) => Consumer<DiaryList>(
            child: Center(
              child: const Text('Start writing about your story.'),
            ),
            builder: (ctx, diaryList, ch) => diaryList.pages.length <= 0
                ? ch!
                : SingleChildScrollView(
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: height - 240,
                          child: PageView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: diaryList.pages.length,
                              controller: _controller,
                              itemBuilder: (context, i) {
                                return Container(
                                  child: Card(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Stack(children: [
                                            Padding(
                                              padding: const EdgeInsets.all(16.0),
                                              child: Align(
                                                child: Text(
                                                  diaryList.pages[i].title!,
                                                  textAlign: TextAlign.start,
                                                ),
                                                alignment: Alignment.center,
                                              ),
                                            ),
                                            Align(
                                              child: Text(
                                                diaryList.pages[i].dateTime!,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle2,
                                              ),
                                              alignment: Alignment.topRight,
                                            ),
                                          ]),
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 12)),
                                          Text(
                                            diaryList.pages[i].pageBody!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 12)),
                                          diaryList.pages[i].pic!.isNotEmpty
                                              ? Stack(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(8.0),
                                                    child: Align(
                                                        alignment:
                                                            Alignment.bottomRight,
                                                        child: ConstrainedBox(
                                                            child: Image.file(
                                                                new File(diaryList
                                                                    .pages[i]
                                                                    .pic!)),
                                                            constraints:
                                                                BoxConstraints
                                                                    .tight(Size
                                                                        .fromRadius(
                                                                            90)))),
                                                  ),
                                                  Align(
                                                    alignment: Alignment.topRight,
                                                    child: ConstrainedBox(
                                                        constraints: BoxConstraints.tight(Size.fromRadius(30)),
                                                        child: Image.asset('assets/images/paper-clip.png')),
                                                  ),]
                                              )
                                              : Container(),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                      Padding(padding: const EdgeInsets.only(bottom: 12)),
                      SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SmoothPageIndicator(
                            controller: _controller,
                            count: diaryList.pages.length,
                            effect: CustomizableEffect(
                                activeDotDecoration:
                                    DotDecoration(color: Colors.black),
                                dotDecoration:
                                    DotDecoration(color: Colors.black38)),
                          )),
                    ]),
                  ),
          ),
        ));
  }
}
