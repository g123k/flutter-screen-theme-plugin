import 'package:flutter/material.dart';
import 'package:screentheme/screentheme.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _lightStatusBar = false;
  bool _lightNavigationBar = false;

  @override
  initState() {
    super.initState();
    _init();
  }

  _init() async {
    await _initStatusBar();
    await _initNavigationBar();
  }

  _initStatusBar() async {
    bool lightStatusBar;
    try {
      lightStatusBar = await ScreenTheme.hasALightStatusBar();
    } on Exception {
      lightStatusBar = false;
    }

    setState(() {
      _lightStatusBar = lightStatusBar;
    });
  }

  _initNavigationBar() async {
    bool lightNavigationBar;
    try {
      lightNavigationBar = await ScreenTheme.hasALightNavigationBar();
    } on Exception {
      lightNavigationBar = false;
    }

    setState(() {
      _lightNavigationBar = lightNavigationBar;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Screen theme plugin example'),
        ),
        body: new Center(
          child: new Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              new Expanded(
                child: new Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: new Text("Light status bar: $_lightStatusBar"),
                    ),
                    new RaisedButton(
                        onPressed: () {
                          enableLightStatusBar();
                        },
                        child: new Text("Light theme")),
                    new RaisedButton(
                      onPressed: () {
                        enableDarkStatusBar();
                      },
                      child: new Text("Dark theme"),
                    )
                  ],
                ),
              ),
              new Expanded(
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: new Text(
                          "Light navigation bar: $_lightNavigationBar"),
                    ),
                    new RaisedButton(
                        onPressed: () {
                          enableLightNavigationBar();
                        },
                        child: new Text("Light theme")),
                    new RaisedButton(
                      onPressed: () {
                        enableDarkNavigationBar();
                      },
                      child: new Text("Dark theme"),
                    ),
                    new RaisedButton(
                      onPressed: () {
                        changeNavigationBarColor();
                      },
                      child: new Text("Red color"),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  changeNavigationBarColor() async {
    await ScreenTheme.updateNavigationBarColor(Colors.red);
  }

  enableLightStatusBar() async {
    await ScreenTheme.lightStatusBar();
    bool hasLightStatusBar = await ScreenTheme.hasALightStatusBar();

    setState(() {
      _lightStatusBar = hasLightStatusBar;
    });
  }

  enableDarkStatusBar() async {
    await ScreenTheme.darkStatusBar(platform: Platform.Android);
    bool hasLightStatusBar = await ScreenTheme.hasALightStatusBar();

    setState(() {
      _lightStatusBar = hasLightStatusBar;
    });
  }

  enableLightNavigationBar() async {
    await ScreenTheme.lightNavigationBar();
    bool hasLightNavigationBar = await ScreenTheme.hasALightNavigationBar();

    setState(() {
      _lightNavigationBar = hasLightNavigationBar;
    });
  }

  enableDarkNavigationBar() async {
    await ScreenTheme.darkNavigationBar();
    bool hasLightNavigationBar = await ScreenTheme.hasALightNavigationBar();

    setState(() {
      _lightNavigationBar = hasLightNavigationBar;
    });
  }
}
