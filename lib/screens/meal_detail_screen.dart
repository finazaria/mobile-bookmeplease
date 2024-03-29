import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/screens/book_comments.dart';

// import '../dummy_data.dart';
import 'category_meals_screen.dart';
import '../main.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-detail';

  final Function toggleFavorite;
  final Function isFavorite;

  MealDetailScreen(this.toggleFavorite, this.isFavorite);

  void addComments(BuildContext ctx, String mealId) {
    // Navigator.of(ctx).pushNamed(
    //   CommentMe.routeName,
    //   arguments: {},
    // );
    Navigator.push(
        ctx, MaterialPageRoute(builder: (context) => CommentMe(mealId)));
  }

  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 150,
      width: 300,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final selectedMeal =
        getDummyMeals().firstWhere((meal) => meal.id == mealId);
    print(mealId);
    print(selectedMeal);
    return Scaffold(
      appBar: AppBar(
        title: Text('${selectedMeal.Name}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Container(
            //   height: 300,
            //   width: double.infinity,
            //   child: Image.network(
            //     selectedMeal.Background_Photo,
            //     fit: BoxFit.cover,
            //   ),
            // ),
            Container(
              margin: EdgeInsets.all(25),
              child: FlatButton(
                child: Text(
                  'Comments',
                  style: TextStyle(fontSize: 20.0),
                ),
                onPressed: () => addComments(context, mealId),
              ),
            ),
            buildSectionTitle(context, 'Steps'),
            buildContainer(
              ListView.builder(
                itemBuilder: (ctx, index) => Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        child: Text('# ${(index + 1)}'),
                      ),
                      // title: Text(
                      //   selectedMeal.steps[index],
                      // ),
                    ),
                    Divider()
                  ],
                ),
                // itemCount: selectedMeal.steps.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          isFavorite(mealId) ? Icons.star : Icons.star_border,
        ),
        onPressed: () => toggleFavorite(mealId),
      ),
    );
  }
}
