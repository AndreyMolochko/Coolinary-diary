
import 'package:flutter/material.dart';
import 'package:sqflite_worker/model/module.dart';
import 'package:sqflite_worker/resourses/module.dart' as App;
import 'package:sqflite_worker/ui/dish_list/module.dart';
import 'package:sqflite_worker/ui/dish_list/widgets/stub_view_list_page.dart';

class DishListPage extends StatefulWidget {
  final DishListViewModelType dishListViewModel;
  final RequestDishListType dishListType;

  DishListPage(this.dishListViewModel, this.dishListType);

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

  @override
  @mustCallSuper
  void dispose() {
    super.dispose();
    widget.dishListViewModel.onDispose();
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      decoration: App.Shapes.whiteGradient,
      child: StreamBuilder(
          stream: widget.dishListViewModel.dishesList,
          builder: (BuildContext context, AsyncSnapshot<List<Dish>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _buildDishItem(context, snapshot.data[index]);
                  });
            } else {
              return StubViewListPage();
            }
          }),
    );
  }

  Widget _buildDishItem(BuildContext context, Dish dish) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(
            top: App.Dimens.smallPadding, left: App.Dimens.normalPadding, right: App.Dimens.normalPadding),
        decoration: BoxDecoration(
            color: App.Colors.gainsboro, borderRadius: BorderRadius.circular(App.Dimens.borderRadiusDishItem)),
        height: 72,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: App.Dimens.normalPadding),
                  child: _buildDishImage(context, dish.path),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: App.Dimens.normalPadding),
              child: _buildArrow(context),
            )
          ],
        ),
      ),
      onTap: () {
        widget.dishListViewModel.clickOnItem(context, dish, widget.dishListType);
      },
    );
  }

  Widget _buildDishImage(BuildContext context, String imageUrl) {
    return CircleAvatar(
        radius: App.Dimens.sizeDishImageItem / 2,
        child: Container(width: App.Dimens.sizeDishImageItem,
            height: App.Dimens.sizeDishImageItem,
            decoration: BoxDecoration(
                shape: BoxShape.circle, image: DecorationImage(fit: BoxFit.fill, image: NetworkImage(imageUrl)))),
        backgroundImage: AssetImage('assets/loading.gif'),
        backgroundColor: Colors.transparent,);
  }

  Widget _buildDishName(BuildContext context, String name) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.6,
        child: Text(name,
            style: App.TextStyles.normalBlackText, overflow: TextOverflow.ellipsis, maxLines: 1, softWrap: false));
  }

  Widget _buildCategory(BuildContext context, String category) {
    return Text(category);
  }

  Widget _buildArrow(BuildContext context) {
    return Container(
        height: App.Dimens.sizeBigIcon,
        width: App.Dimens.sizeBigIcon,
        decoration: BoxDecoration(
            color: App.Colors.dodgerBlue, borderRadius: BorderRadius.circular(App.Dimens.borderRadiusButton)),
        child: Icon(Icons.arrow_forward, color: App.Colors.white, size: App.Dimens.sizeSmallIcon));
  }
}
