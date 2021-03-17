import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'applications.dart';
import 'localization/app_translations.dart';
import 'localization/app_translations_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  AppTranslationsDelegate _newLocaleDelegate;

  @override
  void initState() {
    super.initState();

    _setLanguageIfNeed();
    _newLocaleDelegate = AppTranslationsDelegate(newLocale: null);
    application.onLocaleChanged = _onLocaleChange;
  }
  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics analytics = FirebaseAnalytics();
    return MaterialApp(
      title: 'Culinary Diary',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: DishList(),
      localizationsDelegates: [
        _newLocaleDelegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: application.supportedLocales(),
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics)
      ],
      routes: <String, WidgetBuilder>{
        '/dishList': (BuildContext context) => new DishList(),
      },
    );
  }
  void _onLocaleChange(Locale locale){
    setState(() {
      _newLocaleDelegate = AppTranslationsDelegate(newLocale: locale);
    });
  }

  void _setLanguageIfNeed(){
    AppTranslations.getCurrentLanguage().then((currentLanguage){
      application.onLocaleChanged(Locale(currentLanguage));
    });
  }
}
