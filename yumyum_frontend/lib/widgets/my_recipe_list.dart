import 'package:flutter/material.dart';
import 'package:yumyumfyp/screens/edit_recipe/edit_recipe_view.dart';
import '../models/recipe.dart';
import 'recipe_card.dart';

class MyRecipeList extends StatelessWidget {
  final List<Recipe> recipes;

  final Function(BuildContext, Recipe) onListPressed;
  final Function onRemovePressed;

  const MyRecipeList(
      {Key key,
      @required this.recipes,
      @required this.onListPressed,
      this.onRemovePressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (recipes.length != 0)
        ? ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: recipes.length,
            itemBuilder: (BuildContext context, int index) => Card(
              elevation: 5,
              child: ListTile(
                  // shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(100)),
                  onTap: () => onListPressed(context, recipes[index]),
                  trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                            EditRecipeScreen.routeName,
                            arguments: {'recipe': recipes[index]});
                      },
                      icon: Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {
                        deleteRecipeAlertBox(context, () async {
                          await onRemovePressed(recipes[index].recipeId);
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Recipe is deleted successfully.'),
                            duration: Duration(seconds: 3),
                          ));
                        });
                      },
                      icon: Icon(Icons.delete),
                    ),
                  ]),
                  title: Text(
                    recipes[index].recipeName.toUpperCase(),
                  )),
            ),
          )
        : Center(
            child: Container(
            padding: const EdgeInsets.only(top: 250),
            height: 500.0,
            child: Text("Your recipe list is currently empty"),
          ));
  }

  deleteRecipeAlertBox(BuildContext context, Function deleteMenu) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget yesButton = TextButton(
      child: Text("Yes"),
      onPressed: deleteMenu,
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Delete Recipe"),
      content: Text("Are you sure to delete this recipe?"),
      actions: [
        cancelButton,
        yesButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
