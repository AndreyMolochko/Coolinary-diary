import 'package:flutter/material.dart';
import 'package:sqflite_worker/resourses/module.dart' as App;
import 'package:sqflite_worker/ui/request_dish/widgets/add_dish_photo_page.dart';

import '../module.dart';

class IngredientsAndRecipePage extends StatefulWidget {
  final RequestDishViewModelType _viewModel;

  IngredientsAndRecipePage(this._viewModel);

  @override
  _IngredientsAndRecipePageState createState() => _IngredientsAndRecipePageState();
}

class _IngredientsAndRecipePageState extends State<IngredientsAndRecipePage> {
  final TextEditingController _ingredientsTextController = TextEditingController();
  final TextEditingController _recipeTextController = TextEditingController();
  final FocusNode _ingredientsFocusNode = FocusNode();
  final FocusNode _recipeFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget._viewModel.getPageTitle(context)),
        ),
        body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        Expanded(child: _buildIngredientsList(context), flex: 1),
        Expanded(child: _buildRecipe(context), flex: 1),
        Padding(
          padding: const EdgeInsets.only(
              top: App.Dimens.normalPadding,
              left: App.Dimens.normalPadding,
              right: App.Dimens.normalPadding,
              bottom: App.Dimens.smallPadding),
          child: _buildContinueButton(context),
        )
      ],
    );
  }

  Widget _buildIngredientsList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: App.Dimens.normalPadding,
        left: App.Dimens.normalPadding,
        right: App.Dimens.normalPadding,
      ),
      child: TextField(
          controller: _ingredientsTextController,
          maxLines: 15,
          onSubmitted: (value) => _changeFocusField(context, _ingredientsFocusNode, _recipeFocusNode),
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(border: OutlineInputBorder(), labelText: "Ingredients: ")),
    );
  }

  Widget _buildRecipe(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: App.Dimens.normalPadding,
        left: App.Dimens.normalPadding,
        right: App.Dimens.normalPadding,
      ),
      child: TextField(
          controller: _recipeTextController,
          maxLines: 15,
          onSubmitted: (value) => _continueAction(context),
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(border: OutlineInputBorder(), labelText: "Recipe: ")),
    );
  }

  Widget _buildContinueButton(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        child: Text("Continue"),
        onPressed: () {
          _continueAction(context);
        },
      ),
    );
  }

  void _continueAction(BuildContext context) {
    widget._viewModel.saveIngredients(_ingredientsTextController.text);
    widget._viewModel.saveRecipe(_recipeTextController.text);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => AddDishPhotoPage(widget._viewModel)));
  }

  void _changeFocusField(BuildContext context, FocusNode currentFocusNode, FocusNode nextFocusNode) {
    FocusScope.of(context).requestFocus(nextFocusNode);
  }
}
