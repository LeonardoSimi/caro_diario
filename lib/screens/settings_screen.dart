import 'dart:io';

import 'package:flutter/material.dart';

import 'package:settings_ui/settings_ui.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './privacy_policy_screen.dart';
import './auth_screen.dart';
import './main_diary_screen.dart';
import '../widgets/bottom_nav_bar.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = '/settings_screen';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isLocked = false;

  PackageInfo _packageInfo =
      PackageInfo(appName: '', packageName: '', version: '', buildNumber: '');

  @override
  void initState() {
    super.initState();
    _getLockVal();
    _initPackageInfo();
  }


  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  Future<void> _deleteAppData() async {
    final appDir = await getApplicationSupportDirectory();
    final cacheDir = await getTemporaryDirectory();
    if (appDir.existsSync() && cacheDir.existsSync()) {
      cacheDir.deleteSync();
      appDir.deleteSync();
      print('deleted appdata');
      Navigator.pushNamed(context, AuthScreen.routeName);
    }
  }

  Future<void> _setLock(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_locked', value);
    print('SET LOCK');
  }

  Future<void> _getLockVal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('is_locked') != null) {
      isLocked = (prefs.getBool('is_locked'))!;
      print('got lock value');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //bottomNavigationBar: BottomNavBar(),
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SettingsList(
          sections: [
            SettingsSection(
              title: 'Info',
              tiles: [
                SettingsTile(title: 'App version: ${_packageInfo.version}'),
                SettingsTile(
                    title: 'Package name: ${_packageInfo.packageName}'),
              ],
            ),
            SettingsSection(
              title: 'Biometrics',
              tiles: [
                SettingsTile.switchTile(
                  title: 'Lock your diary',
                  onToggle: (bool value) async {
                    setState(() {
                      isLocked = value;
                      _setLock(value);
                    });
                  },
                  switchValue: isLocked,
                  leading: Icon(Icons.fingerprint_sharp),
                ),
              ],
            ),
            SettingsSection(
              title: 'Advanced',
              tiles: [
                SettingsTile(
                  title: 'DELETE ALL DATA',
                  onPressed: (BuildContext context) {
                    _deleteAppData();
                  },
                  titleTextStyle: TextStyle(color: Colors.red),
                ),
                SettingsTile(
                  title: 'Privacy Policy',
                  onPressed: (BuildContext context) {
                    Navigator.pushNamed(context, PrivacyPolicyScreen.routeName);
                  },
                ),
                SettingsTile(
                  title: 'Log Out',
                  onPressed: (BuildContext context) {
                    if (isLocked)
                    Navigator.pushNamed(context, AuthScreen.routeName);
                    else
                      Navigator.pushNamed(context, MainDiaryScreen.routeName);
                  },
                  titleTextStyle: TextStyle(
                      fontWeight: FontWeight.w800),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
