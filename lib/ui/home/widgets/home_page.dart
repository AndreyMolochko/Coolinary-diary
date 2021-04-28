import 'package:flutter/material.dart';
import 'package:sqflite_worker/localization/app_translations.dart';
import 'package:sqflite_worker/ui/home/module.dart';

class HomePage extends StatefulWidget {
  final HomeViewModelType _viewModel;

  HomePage(this._viewModel);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  List<Tab> tabsList;
  TabController _tabController;

  @override
  void initState() {
    widget._viewModel.initState();
    _tabController = TabController(vsync: this, length: 2);
    _tabController.addListener(() {
      setState(() {
        if (_tabController.indexIsChanging) {
          widget._viewModel.onTabChange(_tabController.index);
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    tabsList = <Tab>[
      Tab(text: AppTranslations.of(context).text('home_screen_my_dishes_title')),
      Tab(text: AppTranslations.of(context).text('home_screen_others_dishes_title'))
    ];
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _tabController,
          tabs: tabsList,
        ),
        title: Text("Culinary diary"),
        actions: <Widget>[
          _buildAdditionIcon(context),
          _buildSettingsIcon(context)
        ],
      ),
      body: _buildBody(context),
    );
  }

  @override
  @mustCallSuper
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  Widget _buildBody(BuildContext context) {
    return IndexedStack(
        index: widget._viewModel.currentPageIndex, children: widget._viewModel.tabBarViews);
  }

  Widget _buildSettingsIcon(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.settings),
      onPressed: () {
        widget._viewModel.onClickSettingsIcon(context);
      },
    );
  }

  Widget _buildAdditionIcon(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.add),
      onPressed: () {
        widget._viewModel.onClickAdditionIcon(context);
      },
    );
  }
}
