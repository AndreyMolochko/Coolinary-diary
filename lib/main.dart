import 'package:flutter/material.dart';
import 'applications.dart';
import 'localization/app_translations_delegate.dart';
import 'screens/dish_list.dart';
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
    _newLocaleDelegate = AppTranslationsDelegate(newLocale: null);
    application.onLocaleChanged = _onLocaleChange;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Culinary Diary',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DishList(),
      localizationsDelegates: [
        _newLocaleDelegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: application.supportedLocales(),
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
}
