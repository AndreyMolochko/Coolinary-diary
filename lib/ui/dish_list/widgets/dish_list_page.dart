import 'package:flutter/material.dart';
import 'package:sqflite_worker/model/module.dart';
import 'package:sqflite_worker/ui/dish_list/module.dart';
import 'package:sqflite_worker/resourses/module.dart' as App;

class DishListPage extends StatefulWidget {
  final DishListViewModelType dishListViewModel;

  DishListPage(this.dishListViewModel);

  @override
  _DishListPageState createState() => _DishListPageState();
}

class _DishListPageState extends State<DishListPage> {

  @override
  void initState() {
     widget.dishListViewModel.initState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
      return FutureBuilder(
          future: widget.dishListViewModel.dishesList,
          builder: (BuildContext context, AsyncSnapshot<List<Dish>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _buildDishItem(context, snapshot.data[index]);
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          });
  }

  Widget _buildDishItem(BuildContext context, Dish dish) {
    return Container(
      margin: EdgeInsets.only(
          top: App.Dimens.smallPadding,
          left: App.Dimens.normalPadding,
          right: App.Dimens.normalPadding),
      decoration: BoxDecoration(color: App.Colors.gainsboro, borderRadius: BorderRadius.circular(App.Dimens.borderRadiusDishItem)),
      height: 72,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: App.Dimens.normalPadding),
            child: _buildDishImage(context, dish.path),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: App.Dimens.normalPadding, left: App.Dimens.mediumPadding),
                child: _buildDishName(context, dish.name),
              ),
              Padding(
                padding: const EdgeInsets.only(top: App.Dimens.smallPadding, left: App.Dimens.mediumPadding),
                child: _buildCategory(context, dish.category),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildDishImage(BuildContext context, String imageUrl) {
    return Icon(Icons.camera_alt);
  }

  Widget _buildDishName(BuildContext context, String name) {
    return Text(name, style: App.TextStyles.normalBlackText);
  }

  Widget _buildCategory(BuildContext context, String category) {
    return Text(category);
  }
}
