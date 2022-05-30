import 'package:flutter/material.dart';
import '../models/recipe.dart';
import 'recipe_card.dart';

class RecipeGrid extends StatelessWidget {
  final List<Recipe> recipes;

  final Function(BuildContext, Recipe) onCardPressed;

  const RecipeGrid(
      {Key key, @required this.recipes, @required this.onCardPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        mainAxisSpacing: 9.0,
        crossAxisSpacing: 9.0,
      ),
      padding: EdgeInsets.all(10.0),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: recipes.length,
      itemBuilder: (BuildContext context, int index) =>
          RecipeCard(recipes[index], onCardPressed),
      // itemBuilder: (BuildContext ctx, index) {
      //   return Container(
      //     alignment: Alignment.center,
      //     child: Column(
      //       children: [
      //         ClipRRect(
      //           borderRadius: BorderRadius.only(
      //               topLeft: Radius.circular(8.0),
      //               topRight: Radius.circular(8.0)),
      //           child: Container(
      //               height: 100,
      //               width: double.infinity,
      //               child: FittedBox(
      //                   fit: BoxFit.cover,
      //                   child:
      //                       Image.asset("assets/images/unknown_user.png"))),
      //         ),
      //         Padding(
      //           padding:
      //               const EdgeInsets.only(top: 4.0, left: 8.0, right: 8.0),
      //           child: Text(
      //             recipes[index].recipeName.toUpperCase(),
      //             overflow: TextOverflow.ellipsis,
      //             maxLines: 1,
      //           ),
      //         ),
      //       ],
      //     ),
      //     decoration: BoxDecoration(
      //         color: Colors.amber, borderRadius: BorderRadius.circular(15)),
      //   );
      // },
    );
  }
}
