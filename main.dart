import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quizapp/shared/ad_manager.dart';
import 'package:quizapp/ui/splashscreen.dart';
import 'services/services.dart';
import 'screens/screens.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/ui/signin.dart';
import 'package:quizapp/ui/signup.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  Future<void> _initAdMob() {
    // TODO: Initialize AdMob SDK
    return FirebaseAdMob.instance.initialize(appId: AdManager.appId);
  }


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<Report>.value(value: Global.reportRef.documentStream),
        StreamProvider<FirebaseUser>.value(value: AuthService().user),
      ],
      child: MaterialApp(
       // home: SplashScreen(),
        // Firebase Analytics
        navigatorObservers: [
          FirebaseAnalyticsObserver(analytics: FirebaseAnalytics()),
        ],
        // Named Routes
        routes: {
          '/': (context) => SignInPage(),
          '/testlogin': (context) => LoginScreen(),
          '/admin': (context) => AdminScreen(),
          '/topics': (context) => TopicsScreen(),
          '/profile': (context) => ProfileScreen(),
          '/about': (context) => AboutScreen(),
          '/settings': (context) => SettingScreen(),
          '/SignUpScreen': (context) => SignUpScreen()

        },

        // Theme
        theme: ThemeData(
          fontFamily: 'Nunito',
          //scaffoldBackgroundColor:  Colors.black,
         // primarySwatch: Colors.blue,
          bottomAppBarTheme: BottomAppBarTheme(
            color: Colors.deepPurple,
          ),
        //brightness: Brightness.,
         //primaryColor: Colors.deepPurple,
          //accentColor: Colors.cyan[600],
          textTheme: TextTheme(
            body1: TextStyle(fontSize: 18),
            body2: TextStyle(fontSize: 16),
            button: TextStyle(letterSpacing: 1.5, fontWeight: FontWeight.bold),
            headline: TextStyle(fontWeight: FontWeight.bold),
            subhead: TextStyle(color: Colors.grey),
          ),
          buttonTheme: ButtonThemeData(),
        ),
      ),
    );
  }
}
