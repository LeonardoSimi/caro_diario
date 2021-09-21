import 'package:flutter/material.dart';

import 'package:local_auth/local_auth.dart';

import '../helpers/authentication.dart';
import './main_diary_screen.dart';

class AuthScreen extends StatelessWidget {

  final LocalAuthentication localAuthentication = LocalAuthentication();
  bool isAuthenticated = false;

  static const routeName = '/auth_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset('assets/images/carodiarioUNC.gif'),
                    Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/8)),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Unlock your Diary', style: Theme.of(context).textTheme.bodyText1,),
                      Padding(padding: EdgeInsets.all(6)),
                      Icon(Icons.lock_open_sharp),
                      Padding(padding: EdgeInsets.all(6)),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.blueGrey,
                              textStyle: Theme.of(context).textTheme.bodyText2
                          ),
                          onPressed: () async {
                            isAuthenticated = await Authentication.authenticateWithBiometrics();
                            if (isAuthenticated){
                              Navigator.of(context).pushReplacementNamed(MainDiaryScreen.routeName);
                            }
                            else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error during the authentication.')));
                            }

                          }, child: Text('Get into your diary'))],)
                  ],
                ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> checkAuth() async {
    bool isBiometricSupported = await localAuthentication.isDeviceSupported();
    bool canCheckBiometrics = await localAuthentication.canCheckBiometrics;

    List<BiometricType> biometricTypes = await localAuthentication.getAvailableBiometrics();

    isAuthenticated = await localAuthentication.authenticate(localizedReason: 'Please complete the biometric authentication to proceed.',);
  }
}
