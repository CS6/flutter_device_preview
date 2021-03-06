import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  runApp(DevicePreview(
    builder: (context) => MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context, nullOk: true);
    return PlatformApp(
      title: 'Flutter Demo',
      locale: DevicePreview.of(context)?.locale, // <--
      builder: DevicePreview.appBuilder, // <--
      supportedLocales: const [
        Locale("en"),
        Locale("fr", "FR"),
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      android: (_) => MaterialAppData(
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: mediaQuery?.platformBrightness == Brightness.dark
            ? ThemeMode.dark
            : ThemeMode.light,
      ),
      ios: (_) => CupertinoAppData(
        theme: CupertinoThemeData(
          brightness: mediaQuery.platformBrightness,
        ),
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);
    final factor = mediaQuery.textScaleFactor;
    final localeCode = Localizations.localeOf(context).toString();
    final dateFormat = DateFormat.yMMMMEEEEd(localeCode);
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            PlatformText(
              'Hello, it is ' + dateFormat.format(DateTime.now()),
              style: theme.textTheme.headline,
            ),
            PlatformButton(
              child: PlatformText("Open"),
              onPressed: () {
                showPlatformDialog(
                  context: context,
                  builder: (context) => Container(
                    height: 300,
                    width: 300,
                    padding: const EdgeInsets.all(20),
                    child: PlatformButton(
                      child: PlatformText("Close"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
