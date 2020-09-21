import 'dart:ffi';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quizapp/shared/ad_manager.dart';
import '../services/services.dart';
import '../shared/shared.dart';
import 'package:provider/provider.dart';
import 'package:pie_chart/pie_chart.dart';
import 'dart:async';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}
class _ProfileScreenState extends State<ProfileScreen>
 {
  final AuthService auth = AuthService();
  Map<String, double> data = new Map();

  BannerAd _bannerAd;
  void _loadBannerAd() {
    _bannerAd
      ..load()
      ..show(anchorType: AnchorType.top);
  }

  InterstitialAd _interstitialAd;
  bool _isInterstitialAdReady;

  void _loadInterstitialAd() {
    _interstitialAd.load();
  }
  void _onInterstitialAdEvent(MobileAdEvent event) {
    switch (event) {
      case MobileAdEvent.loaded:
        _isInterstitialAdReady = true;
        if (_isInterstitialAdReady) {
          _interstitialAd.show();
        }
        break;
      case MobileAdEvent.failedToLoad:
        _isInterstitialAdReady = false;
        print('Failed to load an interstitial ad');
        break;
      case MobileAdEvent.closed:
        //_moveToHome();
        _interstitialAd?.dispose();
        break;
      default:
      // do nothing
    }
  }

  @override
  void initState() {
    _bannerAd = BannerAd(
      adUnitId: AdManager.bannerAdUnitId,
      size: AdSize.banner,
    );
    _loadBannerAd();
    _isInterstitialAdReady = false;
    _interstitialAd = InterstitialAd(
      adUnitId: AdManager.interstitialAdUnitId,
      listener: _onInterstitialAdEvent,
    );
    _loadInterstitialAd();
    super.initState();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    _interstitialAd?.dispose();
    super.dispose();
  }



 /* List<Color> _colors = [
    Colors.teal,
    Colors.blueAccent,
    Colors.amberAccent,
    Colors.redAccent
  ];
  */

  @override
  Widget build(BuildContext context) {
    Report report = Provider.of<Report>(context);
    FirebaseUser user = Provider.of<FirebaseUser>(context);
   report.quizzes.forEach((k,v)=>data.putIfAbsent(k, () => v.toDouble()));
   print(data.toString());
    if (user != null) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text(user.displayName ?? 'Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (user.photoUrl != null)
              Container(
                width: 100,
                height: 100,
                margin: EdgeInsets.only(top: 50),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(user.photoUrl),
                  ),
                ),
              ),
            Text('Account : '+user.email ?? '', style: Theme.of(context).textTheme.headline),
            Spacer(),
            data!=null && data.isNotEmpty ?  PieChart(
              dataMap: data,
             // colorList:
           //   _colors, // if not declared, random colors will be chosen
              animationDuration: Duration(milliseconds: 1500),
              chartLegendSpacing: 32.0,
              chartRadius: MediaQuery.of(context).size.width/
                 1.5, //determines the size of the chart
              showChartValuesInPercentage: false,
              showChartValues: true,
              showChartValuesOutside: false,
              chartValueBackgroundColor: Colors.grey[200],
              showLegends: true,
              legendPosition:
              LegendPosition.top, //can be changed to top, left, bottom
              decimalPlaces: 1,
              showChartValueLabel: true,
              initialAngle: 0,
              chartValueStyle: defaultChartValueStyle.copyWith(
                color: Colors.blueGrey[900].withOpacity(0.9),
              ),
              chartType: ChartType.disc, //can be changed to ChartType.ring
            ):Text(''),

            /*
            if (report != null)
              Text('${report.total ?? 0}',
                  style: Theme.of(context).textTheme.display3),
            Text('Quizzes Completed',
                style: Theme.of(context).textTheme.subhead),

             */
            //Spacer(),
            FlatButton(
                child: Text('logout'),
                color: Colors.red,
                onPressed: () async {
                  //await _loadInterstitialAd();
                  await auth.signOut();
                  Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
                }),
            Spacer()
          ],
        ),
      ),
    );
    } else {
      return LoadingScreen();
    }
  }


}
