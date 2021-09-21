import 'package:flutter/material.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

class PrivacyPolicyScreen extends StatefulWidget {
  static const routeName = '/privacy_policy_screen';

  @override
  _PrivacyPolicyScreenState createState() => _PrivacyPolicyScreenState();
}


class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {

  late String pPolicy;

  @override
  void initState() {
    super.initState();
    privacyPol(context);
  }

  Future<void> privacyPol(BuildContext context) async {
    final policy = await rootBundle.loadString('assets/privacy_policy.txt');
    setState(() {
      pPolicy = policy;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Privacy Policy'),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Container(
              child: Text(
                pPolicy, style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
