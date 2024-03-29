import 'package:comment_box/comment/test.dart';
import 'package:flutter/material.dart';

import './screens/book_comments.dart';
import './dummy_data.dart';
import './screens/tabs_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/filters_screen.dart';
import './screens/categories_screen.dart';
import './models/meal.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../repository.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

const MaterialColor bmpYellow = const MaterialColor(
  0xFFFFB345,
  const <int, Color>{
    50: const Color(0xFFFF8E5),
    100: const Color(0xFFFFB345),
    200: const Color(0xFFFFB345),
    300: const Color(0xFFFFB345),
    400: const Color(0xFFFFB345),
    500: const Color(0xFFFFB345),
    600: const Color(0xFFFFB345),
    700: const Color(0xFFFFB345),
    800: const Color(0xFFFFB345),
    900: const Color(0xFFFFB345),
  },
);

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  List<Book> _availableMeals = DUMMY_MEALS;
  List<Book> _favoriteMeals = [];
  RepoUhuy repo = RepoUhuy();

  // getData() async {
  //   _availableMeals = await repo.getData(book);
  // }

  // void _setFilters(Map<String, bool> filterData) {
  //   setState(() {
  //     _filters = filterData;

  //     _availableMeals = DUMMY_MEALS.where((meal) {
  //       if (_filters['gluten'] && !meal.isGlutenFree) {
  //         return false;
  //       }
  //       if (_filters['lactose'] && !meal.isLactoseFree) {
  //         return false;
  //       }
  //       if (_filters['vegan'] && !meal.isVegan) {
  //         return false;
  //       }
  //       if (_filters['vegetarian'] && !meal.isVegetarian) {
  //         return false;
  //       }
  //       return true;
  //     }).toList();
  //   });
  // }

  void _toggleFavorite(String bookId) {
    final existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == bookId);
    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(
          _availableMeals.firstWhere((meal) => meal.id == bookId),
        );
      });
    }
  }

  bool _isMealFavorite(String id) {
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daftar Buku',
      theme: ThemeData(
        primarySwatch: bmpYellow,
        accentColor: Colors.blue,
        canvasColor: Color.fromRGBO(255, 248, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyText1: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            bodyText2: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            headline6: TextStyle(
              fontSize: 20,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
            )),
      ),
      // home: CategoriesScreen(),
      initialRoute: '/', // default is '/'
      routes: {
        '/': (ctx) => TabsScreen(_favoriteMeals),
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(_availableMeals),
        // MealDetailScreen.routeName: (ctx) =>
        //     MealDetailScreen(_toggleFavorite, _isMealFavorite),
        // FiltersScreen.routeName: (ctx) => FiltersScreen(_filters, _setFilters),
        CommentMe.routeName: (ctx) => CommentMe("1"),
      },
      onGenerateRoute: (settings) {
        print(settings.arguments);
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (ctx) => CategoriesScreen(),
        );
      },
    );
  }
}

// import 'package:flutter/material.dart';
// import 'comments.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Comments about ABC',
//       home: TestMe(),
//     );
//   }
// }
