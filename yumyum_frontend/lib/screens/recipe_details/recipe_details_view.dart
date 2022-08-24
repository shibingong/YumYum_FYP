import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yumyumfyp/models/recipe.dart';
import 'package:yumyumfyp/screens/recipe_details/recipe_details_viewmodel.dart';
import 'package:yumyumfyp/screens/view_recipe_feedback/view_recipe_feedback_view.dart';
import 'package:yumyumfyp/widgets/recipe_nutrition_row.dart';

import '../../app/dependencies.dart';
import '../view.dart';

class RecipeDetailsScreen extends StatelessWidget {
  static const routeName = '/recipe_details';
  static MaterialPageRoute createRoute(args) =>
      MaterialPageRoute(builder: (_) => RecipeDetailsScreen(args['recipe']));

  final Recipe recipe;
  RecipeDetailsScreen(this.recipe);

  @override
  Widget build(BuildContext context) {
    return ConsumerView(
        viewmodel: dependency<RecipeDetailsViewModel>()..init(recipe),
        builder: (context, viewmodel, _) {
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 0,
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: CircleAvatar(
                backgroundColor: Color.fromRGBO(255, 178, 102, 1),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),
            extendBodyBehindAppBar: true,
            backgroundColor: Color.fromRGBO(255, 229, 204, 1),
            body: ListView(
              padding: const EdgeInsets.all(8),
              children: [
                Container(
                    width: double.infinity,
                    child: Image.network(recipe.recipeImage)),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(10, 20, 0, 5),
                  child: Text(
                    recipe.recipeName,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
                  child: Text(
                    recipe.recipeDescription,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                Container(
                  height: 80,
                  padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
                  child: ListView.builder(
                    itemCount: recipe.types.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3.0),
                        child: Chip(
                          elevation: 5,
                          label: Text(
                            recipe.types[index],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          backgroundColor: Color.fromRGBO(255, 178, 102, 1),
                          shadowColor: Colors.black,
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
                  child: Text(
                    'Ingredient List',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: recipe.ingredients.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
                        child: Text(
                          '\u2022 ${recipe.ingredients[index]}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      );
                    }),
                RecipeNutritionRow(
                  calories: recipe.calories,
                  sugar: recipe.sugar,
                  fiber: recipe.fiber,
                  sodium: recipe.sodium,
                  fat: recipe.fat,
                  cholesterol: recipe.cholesterol,
                  protein: recipe.protein,
                  carbohydrates: recipe.carbohydrates,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
                  child: Text(
                    'Steps',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: recipe.steps.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
                        child: Text(
                          '${index + 1}. ${recipe.steps[index]}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      );
                    }),
                Visibility(
                  visible: recipe.videoUrl != '' ? true : false,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Tutorial video here:'),
                          IconButton(
                            icon: Image.asset('assets/images/youtube-icon.png'),
                            iconSize: 25,
                            onPressed: () async {
                              await launchUrl(Uri.parse(recipe.videoUrl));
                              print(recipe.videoUrl);
                            },
                          ),
                        ]),
                  ),
                ),
                SizedBox(
                  height: 50,
                )
              ],
            ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () async => await Navigator.of(context).pushNamed(
                  ViewRecipeFeedbackScreen.routeName,
                  arguments: {'recipe': recipe}),
              label: Text('View Feedback'),
              backgroundColor: Color.fromRGBO(255, 178, 102, 1),
              icon: Icon(
                Icons.reviews,
                size: 35,
                color: Colors.white,
              ),
            ),
          );
        });
  }
}
