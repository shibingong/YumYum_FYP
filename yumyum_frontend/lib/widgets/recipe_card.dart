import 'package:flutter/material.dart';
import '../models/recipe.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final Function(BuildContext, Recipe) onPressed;
  RecipeCard(this.recipe, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed(context, recipe);
      },
      child: PhysicalModel(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        elevation: 8,
        child: Container(
          // color: Colors.white,
          // decoration: BoxDecoration(
          //   border: Border.all(
          //     color: Colors.black,
          //   ),
          //   borderRadius: BorderRadius.circular(12.0),
          //   color: Colors.white,
          //   // boxShadow: [
          //   //   BoxShadow(
          //   //     color: Colors.grey.withOpacity(0.6),
          //   //     blurRadius: 6,
          //   //     offset: Offset(0, 4),
          //   //   ),
          //   // ],
          // ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                Expanded(
                  flex: 4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        topRight: Radius.circular(8.0)),
                    child: Container(
                        height: 100,
                        width: double.infinity,
                        child: FittedBox(
                            fit: BoxFit.cover,
                            child: Image.network(recipe.recipeImage))),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      recipe.recipeName.toUpperCase(),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(recipe.user.profileImage),
                        // backgroundImage: AssetImage('assets/images/user.png'),
                      ),
                      Text(
                        '${recipe.user.name}',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
