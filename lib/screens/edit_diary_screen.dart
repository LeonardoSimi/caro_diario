import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/DPage.dart';
import '../widgets/diary_list.dart';

class EditDiaryScreen extends StatelessWidget {
  final String? title;
  final String? body;
  final String? id;
  final String? date;

  EditDiaryScreen(this.title, this.body, this.id, this.date);

  static const routeName = '/all_diary_screen';

  @override
  Widget build(BuildContext context) {
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
      body: FutureBuilder( future:  Provider.of<DiaryList>(context, listen: false).fetchAndSetPages(),
    builder: (ctx, snapshot) => Consumer<DiaryList>(
    child: Center(
    child: const Text('Start writing about your story.'),
    ),
    builder: (ctx, diaryList, ch) => diaryList.pages.length <= 0
    ? ch!
    : ListView.builder(
    itemCount: diaryList.pages.length,
    itemBuilder: (context, i) {
      return Dismissible(
          direction: DismissDirection.endToStart,
          onDismissed: (direction){
            print(diaryList.pages[i].id);
            DiaryList().deletePages(diaryList.pages[i].id.toString());
            },
          key: Key(diaryList.pages[i].id.toString()),
          child: DPage(id: diaryList.pages[i].id, title: diaryList.pages[i].title, pageBody: diaryList.pages[i].pageBody, dateTime: diaryList.pages[i].dateTime,));
    }
    )

      ),
    ));
  }
}
