import 'package:flutter/material.dart';

abstract class HomeViewModelType {
  List<Widget> tabBarViews;

  int get currentPageIndex;

  void initState();

  void onTabChange(int index);
  void onClickSettingsIcon(BuildContext context);
}
