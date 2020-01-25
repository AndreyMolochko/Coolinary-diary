import 'package:flutter/material.dart';
import 'package:sqflite_worker/ui/home/module.dart';

class HomePage extends StatefulWidget {
  final HomeViewModelType _viewModel;

  const HomePage(this._viewModel);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{

  final List<Tab> tabsList = <Tab>[
    Tab(text: "My dishes"),
    Tab(text: "Other dishes")];
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: tabsList.length);
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
      ),
      body: _buildBody(context),
    );
  }


  @override
  void dispose() {
    _tabController.dispose();
  }

  Widget _buildBody(BuildContext context) {
    return Center(child: Text("My dishes"));
  }
}
