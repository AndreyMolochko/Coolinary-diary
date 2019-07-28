import 'package:flutter/material.dart';
import 'package:sqflite_worker/localization/app_translations.dart';
import 'package:sqflite_worker/model/dish.dart';
import 'package:sqflite_worker/screens/settings.dart';
import 'package:sqflite_worker/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_worker/resourses/strings.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sqflite_worker/screens/update_dish.dart';
import 'package:sqflite_worker/screens/cooking_dish.dart';
import 'package:sqflite_worker/screens/add_dish.dart';
import 'package:sprintf/sprintf.dart';
import 'dart:io';
import 'package:sqflite_worker/app_theme.dart' as AppTheme;

class DishList extends StatefulWidget {
  @override
  _DishListState createState() => _DishListState();
}

class _DishListState extends State<DishList> {
  int indexNavBar = 0;
  static String title = "";
  DatabaseHelper databaseHelper = new DatabaseHelper();
  String currentCategory = listCategories[0];
  List<Dish> dishList;
  List<Dish> filterFullList;
  List<String> popupItems = ["update", "delete"];
  List<String> categoriesList = new List();
  BuildContext contextSnackbar;
  Color backgroundColor = Colors.white;
  int id;
  Dish dish;
  Icon search = new Icon(
    Icons.search,
    color: AppTheme.Colors.black,
  );
  final TextEditingController filterController = new TextEditingController();

  Widget appBarTitle;

  @override
  void initState() {
    super.initState();

    _updateScreen();
    _initFilterController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _initCategories();
    if (appBarTitle == null) {
      setState(() {
        appBarTitle = new Text(AppTranslations.translate(context,
            currentCategory));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (dishList == null) {
      dishList = new List<Dish>();
      _updateScreen();
    }

    Widget body = _getBody();
    if (appBarTitle != null && appBarTitle is! TextField) {
      appBarTitle = new Text(AppTranslations.translate(context,
          currentCategory));
    }

    return Scaffold(
      appBar: _appBar(appBarTitle),
      body: body,
      backgroundColor: backgroundColor,
      bottomNavigationBar: new Theme(
          data: Theme.of(context)
              .copyWith(canvasColor: AppTheme.Colors.orangeLight),
          child: _getBottomNavigationBar()),
    );
  }

  void onTapBottomNavigationBar(int index) {
    setState(() {
      switch (index) {
        case 0:
          _switchNewTapItem(0);
          _updateScreen();
          break;
        case 1:
          _switchNewTapItem(1);
          _updateScreen();
          break;
        case 2:
          _switchNewTapItem(2);
          _updateScreen();
          break;
        case 3:
          _switchNewTapItem(3);
          _updateScreen();
          break;
        case 4:
          _switchNewTapItem(4);
          _updateScreen();
          break;
      }
    });
  }

  BottomNavigationBar _getBottomNavigationBar() {
    return BottomNavigationBar(
        onTap: onTapBottomNavigationBar,
        currentIndex: indexNavBar,
        items: [
          BottomNavigationBarItem(
              icon: new SvgPicture.asset(
                "assets/soup.svg",
                height: 24,
                color: AppTheme.Colors.black,
              ),
              title: Text(
                AppTranslations.translate(context, listCategories[0]),
                style: new TextStyle(color: AppTheme.Colors.black),
              )),
          BottomNavigationBarItem(
              icon: new SvgPicture.asset(
                "assets/wedding-dinner.svg",
                height: 24,
                color: AppTheme.Colors.black,
              ),
              title: new Text(
                AppTranslations.translate(context, listCategories[1]),
                style: new TextStyle(color: AppTheme.Colors.black),
              )),
          BottomNavigationBarItem(
              icon: new SvgPicture.asset(
                "assets/salad.svg",
                height: 24,
                color: AppTheme.Colors.black,
              ),
              title: new Text(
                AppTranslations.translate(context, listCategories[2]),
                style: new TextStyle(color: AppTheme.Colors.black),
              )),
          BottomNavigationBarItem(
              icon: new SvgPicture.asset(
                "assets/birthday-cake.svg",
                height: 24,
                color: AppTheme.Colors.black,
              ),
              title: new Text(
                AppTranslations.translate(context, listCategories[3]),
                style: new TextStyle(color: AppTheme.Colors.black),
              )),
          BottomNavigationBarItem(
              icon: new SvgPicture.asset(
                "assets/lemonade.svg",
                height: 24,
                color: AppTheme.Colors.black,
              ),
              title: new Text(
                AppTranslations.translate(context, listCategories[4]),
                style: new TextStyle(color: AppTheme.Colors.black),
              ))
        ]);
  }

  void _updateScreen() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Dish>> dishListFuture =
      databaseHelper.getDishesByCategory(currentCategory);
      dishListFuture.then((dishList) {
        setState(() {
          this.dishList = dishList;
          filterFullList = dishList;
        });
      });
    });
  }

  Widget _appBar(Widget appBarTitle) {
    return AppBar(
      title: appBarTitle,
      actions: <Widget>[
        IconButton(
          icon: search,
          onPressed: _searchPressed,
          color: AppTheme.Colors.black,
        ),
        IconButton(
          icon: new Icon(
            Icons.add,
            color: AppTheme.Colors.black,
          ),
          onPressed: _onClickAdd,
        ),
        IconButton(
          icon: new Icon(
            Icons.more_vert,
            color: AppTheme.Colors.black,
          ),
          onPressed: _clickSettingsItem,
        ),
      ],
      backgroundColor: AppTheme.Colors.orangeDark,
    );
  }

  void _onClickAdd() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => new AddDish(_updateScreen)));
  }

  void onClickPopupMenu(String action) {
    if (action == popupItems[0]) {
      _onClickUpdateDish();
    } else if (action == popupItems[1]) {
      _onClickDeleteDish();
    }
  }

  void _onClickUpdateDish() {
    _showUpdateDishScreen();
  }

  void _onClickDeleteDish() {
    _showSnackbarForDelete();
  }

  void _showSnackbarForDelete() {
    final snackbar = new SnackBar(
      content: Text(
        AppTranslations.translate(context, "delete_dish"),
      ),
      action: SnackBarAction(
          label: AppTranslations.translate(context, "yes"),
          onPressed: _clickOnSnackbar),
      duration: new Duration(days: 1000),
    );
    Scaffold.of(contextSnackbar).showSnackBar(snackbar);
  }

  void _clickOnSnackbar() {
    _deleteDish(id);
  }

  void _deleteDish(int id) async {
    int result = await databaseHelper.deleteDish(id);
    _updateScreen();
  }

  void _showUpdateDishScreen() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => new UpdateDish(dish, _updateScreen)));
  }

  void _showCookingScreen(Dish dish) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => new CookingDish((dish))));
  }

  void _showSettings() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => new SettingsWidget()));
  }

  void _searchPressed() {
    setState(() {
      if (search.icon == Icons.search) {
        search = new Icon(Icons.close);
        appBarTitle = new TextField(
          style: new TextStyle(color: AppTheme.Colors.black, fontSize: 18.0),
          controller: filterController,
          decoration: new InputDecoration(
              prefixIcon: new Icon(
                Icons.search,
                color: AppTheme.Colors.black,
              ),
              hintText: AppTranslations.translate(context, "search"),
              hintStyle: new TextStyle(color: AppTheme.Colors.black)),
        );
      } else {
        filterController.clear();
        search = new Icon(Icons.search);
        appBarTitle = new Text(
          currentCategory,
          style: TextStyle(color: AppTheme.Colors.black),
        );
      }
    });
  }

  void _initFilterController() {
    filterController.addListener(() {
      if (filterController.text.isEmpty || filterController.text.length < 1) {
        setState(() {
          dishList = filterFullList;
        });
      } else {
        setState(() {
          dishList = _getFilterList(filterController.text);
        });
      }
    });
  }

  List<Dish> _getFilterList(String title) {
    List<Dish> filterList = new List();

    for (int i = 0; i < filterFullList.length; i++) {
      if (filterFullList[i].name.toLowerCase().contains(title.toLowerCase())) {
        filterList.add(filterFullList[i]);
      }
    }

    return filterList;
  }

  Widget _getDishesWidget() {
    return ListView.builder(
      itemBuilder: (context, position) {
        return Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
          child: Container(
            decoration: BoxDecoration(
                color: AppTheme.Colors.white,
                borderRadius: new BorderRadius.all(Radius.circular(6.0))),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                      child: Text(
                        dishList[position].name,
                        style: new TextStyle(fontSize: 24.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, right: 8.0),
                      child: PopupMenuButton<String>(
                        onSelected: onClickPopupMenu,
                        icon: Icon(Icons.more_horiz),
                        itemBuilder: (BuildContext context) {
                          id = dishList[position].id;
                          dish = dishList[position];
                          contextSnackbar = context;
                          return popupItems.map((String choice) {
                            return PopupMenuItem<String>(
                                value: choice,
                                child: Text(AppTranslations.translate
                                  (context, choice),)
                            );
                          }).toList();
                        },
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(),
                  child: dishList[position].path.length > 0
                      ? Image.file(new File(dishList[position].path))
                      : Icon(Icons.image),
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 8.0),
                      child: Text(
                        sprintf(
                            AppTranslations.translate(
                                context, "cooked_dish_time"),
                            [dishList[position].counterCooking]),
                        style: new TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 16.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                          dishList[position]
                              .ingredientList
                              .replaceAll(r'$', '\n'),
                          style: new TextStyle(fontSize: 18.0)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                    left: 16.0,
                    bottom: 8.0,
                  ),
                  child: Row(
                    children: <Widget>[
                      RaisedButton(
                          child: Text(
                            AppTranslations.translate(context, "cook"),
                          ),
                          color: AppTheme.Colors.orangePrimary,
                          onPressed: () {
                            _showCookingScreen(dishList[position]);
                          }),
                    ],
                    /*children: <Widget>[
                      InkWell(
                        child: Text(AppTranslations.translate(context, "cook"),
                            style: new TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent)),
                        onTap: () {
                          _showCookingScreen(dishList[position]);
                        },
                      ),
                    ],*/
                  ),
                ),
              ],
            ),
          ),
        );
      },
      itemCount: dishList.length,
    );
  }

  Widget _getBody() {
    Widget body;
    if (dishList.length == 0) {
      body = _noDataAvailable();
      backgroundColor = Colors.white;
    } else {
      body = _getDishesWidget();
      backgroundColor = AppTheme.Colors.orangePrimary;
    }

    return body;
  }

  Widget _noDataAvailable() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: Text(
                AppTranslations.translate(context, "no_data_available"),
                textAlign: TextAlign.center,
                style: new TextStyle(fontSize: 18.0),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _switchNewTapItem(int index) {
    title = categoriesList[index];
    currentCategory = listCategories[index];
    search = new Icon(Icons.search);
    filterController.clear();
    indexNavBar = index;
    setState(() {
      appBarTitle = new Text(
        AppTranslations.translate(context, currentCategory),
        style: TextStyle(color: AppTheme.Colors.black),
      );
    });
  }

  void _clickSettingsItem() {
    _showSettings();
  }

  void _initCategories() {
    categoriesList.add(AppTranslations.translate(context, "soups"));
    categoriesList.add(AppTranslations.translate(context, "main"));
    categoriesList.add(AppTranslations.translate(context, "salads"));
    categoriesList.add(AppTranslations.translate(context, "dessert"));
    categoriesList.add(AppTranslations.translate(context, "drinks"));
  }

}
