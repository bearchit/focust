import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:focust/screens/focust.dart';
import 'package:focust/screens/settings.dart';
import 'package:focust/screens/tasks.dart';
import 'package:getflutter/getflutter.dart';

void main() => runApp(App());

const String AD_MOB_APP_ID = 'ca-app-pub-6651910437588790~3530883768';
const String AD_MOB_AD_ID = 'ca-app-pub-6651910437588790/3625224867';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Root();
  }
}

class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  double _paddingBottom = 48.0;
  BannerAd _bannerAd;
  FirebaseAnalytics _analytics = FirebaseAnalytics();

  BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: AD_MOB_AD_ID,
      size: AdSize.smartBanner,
      targetingInfo: MobileAdTargetingInfo(
        keywords: ["pomodoro", "timer", "focus", "study", "productivity"],
        childDirected: false,
      ),
      listener: (MobileAdEvent event) {
        if (event == MobileAdEvent.failedToLoad) {
          setState(() {
            _paddingBottom = 0.0;
          });
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance.initialize(appId: AD_MOB_APP_ID);
    _bannerAd = createBannerAd()
      ..load()
      ..show();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Focust',
      theme: ThemeData(
        brightness: Brightness.light,
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.red,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: Main(),
      builder: (BuildContext context, Widget widget) {
        return Padding(
          child: widget,
          padding: EdgeInsets.only(bottom: _paddingBottom),
        );
      },
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: _analytics),
      ],
    );
  }
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  List<Widget> fakeBottomButtons = <Widget>[
    Container(height: 50.0),
  ];

  List<Widget> _screens = <Widget>[
    FocustScreen(),
    TasksScreen(),
  ];
  int _selectedScreenIndex = 0;

  void _handleSelectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GFAppBar(
        title: Text("Focust"),
        actions: <Widget>[
          GFIconButton(
            icon: Icon(
              Icons.settings,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
            type: GFButtonType.transparent,
          )
        ],
      ),
      body: _screens.elementAt(_selectedScreenIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            title: Text('Focust'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted),
            title: Text("Tasks"),
          ),
        ],
        currentIndex: _selectedScreenIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _handleSelectScreen,
      ),
    );
  }
}
