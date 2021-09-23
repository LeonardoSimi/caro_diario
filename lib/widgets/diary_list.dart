import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../models/DPage.dart';
import '../helpers/db_helper.dart';

class DiaryList with ChangeNotifier {
  List<DPage> _pages = [];

  List<DPage> get pages {
    return [..._pages];
  }

  String? imagePath;

  Future<void> addPage(String nId, String nTitle, String nBody, String dateTime,) async {
    final db = await DBHelper.database();
    DateTime now = DateTime.now();
    String dateTimeFormatted =
        DateFormat('dd-MM-yyyy,  \n          kk:mm').format(now);
    final newPage = DPage(
      title: nTitle,
      pageBody: nBody,
      dateTime: dateTimeFormatted,
      id: nId,
      pic: imagePath,
    );
    _pages.add(newPage);
    notifyListeners();
    await db.insert('user_diary', {
      'title': newPage.title,
      'body': newPage.pageBody,
      'date': newPage.dateTime,
      'id': newPage.id,
      'picture': newPage.pic != null ? newPage.pic : ''
    });
    print('added page with title ${newPage.title}, ${newPage.id}, ${newPage.pic}');
  }

  Future<void> fetchAndSetPages() async {
    final db = await DBHelper.database();
    final data = await DBHelper.getData('user_diary');
    _pages = data
        .map((item) => DPage(
              id: item['id'],
              title: item['title'],
              pageBody: item['body'],
              dateTime: item['date'],
              pic: item['picture'],
            ))
        .toList();
    notifyListeners();
  }

  deletePages(String pageId) async {
    var db = await DBHelper.database();
    var table = 'user_diary';
    print('deleted page from db');
    await db.rawDelete('DELETE FROM $table WHERE id = ?', [pageId]);
  }

  getImagePath(XFile image) {
    imagePath = image.path;

    if (image.path.isEmpty)
      imagePath = '';

    print(imagePath);
  }
}
