import 'package:flutter/material.dart';
import 'package:sqflite_worker/model/module.dart';
import 'package:sqflite_worker/ui/dialogs/module.dart';
import 'package:sqflite_worker/ui/dish_info/module.dart';
import 'package:sqflite_worker/resourses/module.dart' as App;

class DishInfoPage extends StatefulWidget {
  final DishInfoViewModelType _dishInfoViewModel;

  DishInfoPage(this._dishInfoViewModel);

  @override
  _DishInfoPageState createState() => _DishInfoPageState();
}

class _DishInfoPageState extends State<DishInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget._dishInfoViewModel.dish.name), actions: [
        if (widget._dishInfoViewModel.requestDishListType == RequestDishListType.myDishes)
          _buildEditButton(context, widget._dishInfoViewModel.dish),
        if (widget._dishInfoViewModel.requestDishListType == RequestDishListType.myDishes)
          _buildDeleteButton(context, widget._dishInfoViewModel.dish)
      ]),
      body: _buildBody(context, widget._dishInfoViewModel.dish),
    );
  }

  Widget _buildBody(BuildContext context, Dish dish) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildDishImage(context, dish.path),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: App.Dimens.smallPadding, left: App.Dimens.normalPadding),
            child: _buildIngredientsLabel(context),
          ),
          Padding(
            padding: const EdgeInsets.only(top: App.Dimens.smallPadding, left: App.Dimens.normalPadding),
            child: _buildIngredients(context, dish.ingredientList),
          ),
          Padding(
            padding: const EdgeInsets.only(top: App.Dimens.smallPadding, left: App.Dimens.normalPadding),
            child: _buildRecipeLabel(context),
          ),
          Padding(
            padding: const EdgeInsets.only(top: App.Dimens.smallPadding, left: App.Dimens.normalPadding),
            child: _buildRecipe(context, dish.recipe),
          )
        ],
      ),
    );
  }

  Widget _buildEditButton(BuildContext context, Dish dish) {
    return IconButton(
        icon: Icon(Icons.edit),
        onPressed: () {
          widget._dishInfoViewModel.onClickUpdate(context, dish);
        });
  }

  Widget _buildDeleteButton(BuildContext context, Dish dish) {
    return IconButton(
        icon: Icon(Icons.delete_rounded),
        onPressed: () {
          _showDialog(context, "Delete dish", "Do you really want to delete this dish?", [TextButton(onPressed: () {
            Navigator.of(context).pop();
          }, child: Text("Cancel")),
          TextButton(onPressed: () {
            widget._dishInfoViewModel.onClickDelete(context, dish);
          }, child: Text("Ok"))]);
        });
  }

  Widget _buildDishImage(BuildContext context, String url) {
    return Container(
        height: 300,
        margin: EdgeInsets.only(
            top: App.Dimens.normalPadding, left: App.Dimens.normalPadding, right: App.Dimens.normalPadding),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(App.Dimens.borderRadiusAddImage),
            child: FadeInImage.assetNetwork(placeholder: 'assets/loading.gif', image: url)));
  }

  Widget _buildIngredientsLabel(BuildContext context) {
    return Text("Ingredients: ", style: App.TextStyles.normalBlackText.copyWith(fontWeight: FontWeight.w400));
  }

  Widget _buildIngredients(BuildContext context, String ingredients) {
    return Text(ingredients, style: App.TextStyles.normalBlackText);
  }

  Widget _buildRecipeLabel(BuildContext context) {
    return Text("Recipe: ", style: App.TextStyles.normalBlackText.copyWith(fontWeight: FontWeight.w400));
  }

  Widget _buildRecipe(BuildContext context, String recipe) {
    return Text(recipe, style: App.TextStyles.normalBlackText);
  }

  void _showDialog(BuildContext context, String title, String message, List<Widget> actions) {
    DialogPresenterType dialogPresenter = DialogPresenter(title, message, actions: actions);
    dialogPresenter.show(context);
  }
}
