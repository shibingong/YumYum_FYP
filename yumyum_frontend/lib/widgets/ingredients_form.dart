import 'package:flutter/material.dart';
import 'package:yumyumfyp/widgets/custom_text_field.dart';

class IngredientsForm extends StatelessWidget {
  final int ingredientsNum;
  final List<TextEditingController> ingredientController;
  final List<TextEditingController> ingredientQuantityController;
  final Function addIngredientsButtonOnPressed;
  final Function removeIngredientsButtonOnPressed;
  const IngredientsForm(
      {Key key,
      this.ingredientsNum,
      this.ingredientController,
      this.ingredientQuantityController,
      this.addIngredientsButtonOnPressed,
      this.removeIngredientsButtonOnPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: ingredientsNum,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(left: 29, right: 29, bottom: 5),
        child: Container(
          height: 60,
          child: Row(children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: CustomTextField(
                  hintText: 'Ingredient ' + (index + 1).toString(),
                  controller: ingredientController[index],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: CustomTextField(
                  hintText: 'Quantity',
                  controller: ingredientQuantityController[index],
                ),
              ),
            ),
            Visibility(
              visible: index == ingredientsNum - 1,
              child: Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.only(bottom: 20),
                  child: IconButton(
                    onPressed: () {
                      addIngredientsButtonOnPressed(index);
                    },
                    icon: Icon(
                      Icons.add_circle,
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: index > 0,
              child: Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.only(bottom: 20),
                  child: IconButton(
                    onPressed: () {
                      removeIngredientsButtonOnPressed(index);
                    },
                    icon: Icon(
                      Icons.remove_circle,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
