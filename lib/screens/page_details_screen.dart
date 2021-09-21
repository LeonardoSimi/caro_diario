import 'package:flutter/material.dart';

class PageDetailsScreen extends StatelessWidget {
  final String? title;
  final String? body;
  final String? date;

  PageDetailsScreen({this.title, this.body, this.date});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
        Center(
          child: Card(
              child: ListTile(
                          title: Text(title!, style: Theme.of(context).textTheme.bodyText2,),
                          subtitle: Text(body!, style: Theme.of(context).textTheme.bodyText1,),
                        ),
          ),
        ),
    );
  }
}
