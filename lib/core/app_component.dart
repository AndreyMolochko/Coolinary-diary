import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:injector/injector.dart';
import 'package:sqflite_worker/core/app_provider.dart';
import 'package:sqflite_worker/core/application/culinary_diary.dart';
import 'package:sqflite_worker/localization/app_translations.dart';
import 'package:sqflite_worker/localization/app_translations_delegate.dart';
import 'package:sqflite_worker/providers/module.dart';
import 'package:sqflite_worker/ui/authorization/module.dart';
import 'package:sqflite_worker/ui/dish_info/module.dart';
import 'package:sqflite_worker/ui/guide/module.dart';
import 'package:sqflite_worker/ui/home/module.dart';
import 'package:sqflite_worker/ui/home/widgets/home_page.dart';

import '../applications.dart';

class AppComponent extends StatefulWidget {
  final CulinaryDiary _application;
  final Injector _injector;

  AppComponent(this._application, this._injector);

  @override
  _AppComponentState createState() => _AppComponentState(_application);
}

class _AppComponentState extends State<AppComponent> {
  AppTranslationsDelegate _newLocaleDelegate;
  final CulinaryDiary _application;

  _AppComponentState(this._application);

  @override
  void initState() {
    _setLanguageIfNeed();
    _newLocaleDelegate = AppTranslationsDelegate(newLocale: null);
    application.onLocaleChanged = _onLocaleChange;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _runApp(widget._application.firstWidget);
  }

  @override
  void dispose() {
    widget._application.onTerminate();
    super.dispose();
  }

  AppProvider _runApp(Widget widget) {
    final app = MaterialApp(
      title: 'Culinary Diary',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: widget,
      localizationsDelegates: [
        _newLocaleDelegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      onGenerateRoute: onGenerateRoute,
      supportedLocales: application.supportedLocales()
    );
    return AppProvider(app, _application);
  }

  void _onLocaleChange(Locale locale) {
    setState(() {
      _newLocaleDelegate = AppTranslationsDelegate(newLocale: locale);
    });
  }

  void _setLanguageIfNeed() {
    widget._injector.get<LocaleProviderType>().getLocale().then((value) => application.onLocaleChanged(Locale(value)));
  }

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/guide':
        return MaterialPageRoute(
            builder: (BuildContext context) => GuidePage(settings.arguments as GuideViewModelType));
      case '/home':
        return MaterialPageRoute(builder: (BuildContext context) => HomePage(settings.arguments as HomeViewModelType));
      case '/authorization':
        return MaterialPageRoute(
            builder: (BuildContext context) => AuthorizationPage(settings.arguments as AuthorizationViewModelType));
      case '/dish_info':
        return MaterialPageRoute(
            builder: (BuildContext context) => DishInfoPage(settings.arguments as DishInfoViewModelType));
      default:
        return null;
    }
  }
}
