import 'package:flutter/material.dart';
import 'package:sqflite_worker/ui/home/module.dart';

class HomePage extends StatefulWidget {
  final HomeViewModelType _viewModel;

  HomePage(this._viewModel);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  final List<Tab> tabsList = <Tab>[Tab(text: "My dishes"), Tab(text: "Other dishes")];
  TabController _tabController;

  @override
  void initState() {
    widget._viewModel.initState();
    _tabController = TabController(vsync: this, length: tabsList.length);
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
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _tabController,
          tabs: tabsList,
        ),
        title: Text("Culinary diary"),
        actions: <Widget>[
          _buildSettingsIcon(context)
        ],
      ),
      body: _buildBody(context),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
  }

  Widget _buildBody(BuildContext context) {
    return IndexedStack(
        index: widget._viewModel.currentPageIndex, children: widget._viewModel.tabBarViews);
  }

  Widget _buildSettingsIcon(BuildContext context){
    return IconButton(
      icon: Icon(Icons.settings),
      onPressed: () {
        widget._viewModel.onClickSettingsIcon(context);
      },
    );
  }
}
