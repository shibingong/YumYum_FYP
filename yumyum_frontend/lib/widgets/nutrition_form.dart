import 'package:flutter/material.dart';

import 'custom_text_field.dart';

class NutritionForm extends StatelessWidget {
  final TextEditingController caloriesController;
  final TextEditingController sugarController;
  final TextEditingController fiberController;
  final TextEditingController sodiumController;
  final TextEditingController fatController;
  final TextEditingController cholesterolController;
  final TextEditingController proteinController;
  final TextEditingController carbohydratesController;

  const NutritionForm(
      {Key key,
      this.caloriesController,
      this.sugarController,
      this.fiberController,
      this.sodiumController,
      this.fatController,
      this.cholesterolController,
      this.proteinController,
      this.carbohydratesController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 29, right: 29, bottom: 5),
          child: Row(children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.only(left: 5, right: 5),
                height: 60,
                child: CustomTextField(
                  hintText: 'Calories',
                  controller: caloriesController,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.only(left: 5, right: 5),
                height: 60,
                child: CustomTextField(
                  hintText: 'Sugar (g)',
                  controller: sugarController,
                ),
              ),
            ),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 29, right: 29, bottom: 5),
          child: Row(children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.only(left: 5, right: 5),
                height: 60,
                child: CustomTextField(
                  hintText: 'Fiber (g)',
                  controller: fiberController,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.only(left: 5, right: 5),
                height: 60,
                child: CustomTextField(
                  hintText: 'Sodium (mg)',
                  controller: sodiumController,
                ),
              ),
            ),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 29, right: 29, bottom: 5),
          child: Row(children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.only(left: 5, right: 5),
                height: 60,
                child: CustomTextField(
                  hintText: 'Fat (g)',
                  controller: fatController,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.only(left: 5, right: 5),
                height: 60,
                child: CustomTextField(
                  hintText: 'Cholesterol (mg)',
                  controller: cholesterolController,
                ),
              ),
            ),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 29, right: 29, bottom: 5),
          child: Row(children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.only(left: 5, right: 5),
                height: 60,
                child: CustomTextField(
                  hintText: 'Protein (g)',
                  controller: proteinController,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.only(left: 5, right: 5),
                height: 60,
                child: CustomTextField(
                  hintText: 'Carbohydrates (g)',
                  controller: carbohydratesController,
                ),
              ),
            ),
          ]),
        ),
      ],
    );
  }
}
