import 'dart:io';
import 'dart:core';
import 'package:flutter/material.dart';

class DPage extends StatelessWidget {
  String? id;
  String? title;
  String? pageBody;
  String? dateTime;
  String? pic; //TODO implement imagepicker
  String? location; //TODO implement w gmaps

  DPage(
      {this.id,
      this.title,
      this.pageBody,
      this.dateTime,
      this.pic,
      this.location});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
          children: [
            Stack(children: [
              Align(alignment: Alignment.topRight, child: Text(dateTime!, style: TextStyle(fontSize: 12, color: Colors.black54),),),
              Align(alignment: Alignment.topCenter, child: Text(title!, overflow: TextOverflow.ellipsis,)),
          ],
      ),
      Text(pageBody!,overflow: TextOverflow.ellipsis, maxLines: 3),
      ]),
      );
  }
}
