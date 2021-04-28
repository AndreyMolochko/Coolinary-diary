import 'package:flutter/material.dart';
import 'package:sqflite_worker/localization/app_translations.dart';
import 'package:sqflite_worker/resourses/module.dart' as App;

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
  bool _isEnabledButton = false;

  @override
  void initState() {
    if (_ingredientsTextController.text.isEmpty) {
      _ingredientsTextController.text =
      widget._viewModel.dish.ingredientList != null ? widget._viewModel.dish.ingredientList : "";
    }
    if (_recipeTextController.text.isEmpty) {
      _recipeTextController.text = widget._viewModel.dish.recipe != null ? widget._viewModel.dish.recipe : "";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _isEnabledButton =
        _ingredientsTextController.text.trim().isNotEmpty && _recipeTextController.text.trim().isNotEmpty;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(widget._viewModel.getPageTitle(context)),
        ),
        body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      decoration: App.Shapes.whiteGradient,
      child: Column(
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
      ),
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
          style: TextStyle(textBaseline: TextBaseline.alphabetic),
          onChanged: _validateFields,
          controller: _ingredientsTextController,
          maxLines: 15,
          onSubmitted: (value) => _changeFocusField(context, _ingredientsFocusNode, _recipeFocusNode),
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: AppTranslations.of(context).text('ingredients_and_recipe_screen_ingredients_text_field'))),
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
          onChanged: _validateFields,
          controller: _recipeTextController,
          maxLines: 15,
          onSubmitted: (value) => _continueAction(context),
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: AppTranslations.of(context).text('ingredients_and_recipe_screen_recipe_text_field'))),
    );
  }

  Widget _buildContinueButton(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        child: Text(AppTranslations.of(context).text('ingredients_and_recipe_screen_continue_button'),
            style: App.TextStyles.normalBlackText),
        style: App.Shapes.primaryButtonStyle,
        onPressed: _isEnabledButton ? () {
          _continueAction(context);
        } : null,
      ),
    );
  }
  
  void _validateFields(String text) {
    setState(() {
      _isEnabledButton = (_ingredientsTextController.text.trim().isNotEmpty && _recipeTextController.text.trim().isNotEmpty);
    });
  }

  void _continueAction(BuildContext context) {
    widget._viewModel.clickContinueRecipeIngredients(context, _ingredientsTextController.text, _recipeTextController.text);
  }

  void _changeFocusField(BuildContext context, FocusNode currentFocusNode, FocusNode nextFocusNode) {
    FocusScope.of(context).requestFocus(nextFocusNode);
  }
}
