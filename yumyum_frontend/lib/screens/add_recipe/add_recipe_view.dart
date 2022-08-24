import 'package:flutter/material.dart';
import 'package:yumyumfyp/widgets/dropdownlist.dart';
import 'package:yumyumfyp/widgets/ingredients_form.dart';
import 'package:yumyumfyp/widgets/nutrition_form.dart';
import 'package:yumyumfyp/widgets/steps_form.dart';

import '../../app/dependencies.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../view.dart';
import 'add_recipe_viewmodel.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class AddRecipeScreen extends StatelessWidget {
  static const routeName = '/add_recipe';
  static MaterialPageRoute createRoute(args) =>
      MaterialPageRoute(builder: (_) => AddRecipeScreen());

  @override
  Widget build(BuildContext context) {
    return ConsumerView(
        viewmodel: dependency<AddRecipeViewModel>()..init(),
        builder: (context, viewmodel, _) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Add Recipe",
                style: TextStyle(color: Colors.black),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              iconTheme: IconThemeData(color: Colors.black),
            ),
            // extendBodyBehindAppBar: true,
            backgroundColor: Color.fromRGBO(255, 229, 204, 1),
            body: SingleChildScrollView(
              child: Stack(children: [
                SingleChildScrollView(
                  child: Form(
                    key: viewmodel.formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 29, right: 29, top: 5, bottom: 10),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: viewmodel.tempImage == null
                                      ? Image.asset(
                                          'assets/images/empty_image.png')
                                      : Image.file(viewmodel.tempImage),
                                  height: 100,
                                ),
                                ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    primary: Color.fromRGBO(255, 178, 102, 1),
                                  ),
                                  onPressed: () {
                                    viewmodel.chooseImage();
                                  },
                                  icon: Icon(
                                    Icons.add_photo_alternate,
                                    size: 24.0,
                                  ),
                                  label: Text('Upload Image'),
                                ),
                              ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 29, right: 29, top: 5),
                          child: Container(
                            height: 60,
                            child: CustomTextField(
                              hintText: 'Name',
                              obscured: false,
                              controller: viewmodel.recipeNameController,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 29, right: 29, top: 5),
                          child: Container(
                            height: 60,
                            child: CustomTextField(
                              hintText: 'Description',
                              obscured: false,
                              controller: viewmodel.recipeDescriptionController,
                            ),
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(
                        //       left: 29, right: 29, bottom: 5),
                        //   child: Container(
                        //     height: 60,
                        //     child: CustomTextField(
                        //       hintText: 'Types',
                        //       controller: viewmodel.typesController,
                        //     ),
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 29, right: 29, bottom: 5),
                          child: Container(
                            height: 60,
                            child: CustomTextField(
                              hintText: 'YouTube Video URL (Optional)',
                              controller: viewmodel.videoUrlController,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 29, right: 29, bottom: 5),
                          child: MultiSelectDialogField(
                            items: (viewmodel.type as List)
                                .map((e) => MultiSelectItem(e, e))
                                .toList(),
                            validator: (values) {
                              if ((values == null || values.isEmpty)) {
                                return 'This field cannot be empty.';
                              }
                              return null;
                            },
                            title: Text("Type"),
                            selectedColor: Colors.orange,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6.0)),
                              border: Border.all(
                                color: Colors.black,
                              ),
                            ),
                            buttonIcon: Icon(
                              Icons.sort,
                              color: Colors.black,
                            ),
                            buttonText: Text(
                              "Type",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                            onConfirm: (results) {
                              viewmodel.selectedType =
                                  results.map((e) => e.toString()).toList();
                            },
                          ),
                        ),
                        Divider(
                          color: Colors.grey,
                          height: 30,
                          indent: 20,
                          endIndent: 20,
                          thickness: 1,
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 35, bottom: 15),
                          alignment: Alignment.centerLeft,
                          child: Text(
                              "Ingredients (Please specify the quantity eg. 100g, 500ml)"),
                        ),
                        IngredientsForm(
                          ingredientsNum: viewmodel.ingredientsNum,
                          ingredientController:
                              viewmodel.ingredientsControllers,
                          ingredientQuantityController:
                              viewmodel.ingredientsQuantityControllers,
                          addIngredientsButtonOnPressed:
                              viewmodel.addIngredientsButtonOnPressed,
                          removeIngredientsButtonOnPressed:
                              viewmodel.removeIngredientsButtonOnPressed,
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 10),
                          child: SizedBox(
                            width: 200,
                            child: ElevatedButton.icon(
                              onPressed: () async {
                                await viewmodel.getNutrition();
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Color.fromRGBO(255, 178, 102, 1),
                              ),
                              icon: Icon(
                                Icons.eco,
                                size: 24.0,
                              ),
                              label: Text('Generate Nutrition'),
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.grey,
                          height: 30,
                          indent: 20,
                          endIndent: 20,
                          thickness: 1,
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 35, bottom: 15),
                          alignment: Alignment.centerLeft,
                          child: Text("Nutrition"),
                        ),
                        NutritionForm(
                          caloriesController: viewmodel.caloriesController,
                          sugarController: viewmodel.sugarController,
                          fiberController: viewmodel.fiberController,
                          sodiumController: viewmodel.sodiumController,
                          fatController: viewmodel.fatController,
                          cholesterolController:
                              viewmodel.cholesterolController,
                          proteinController: viewmodel.proteinController,
                          carbohydratesController:
                              viewmodel.carbohydratesController,
                        ),
                        Divider(
                          color: Colors.grey,
                          height: 30,
                          indent: 20,
                          endIndent: 20,
                          thickness: 1,
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 35, bottom: 15),
                          alignment: Alignment.centerLeft,
                          child: Text("Steps"),
                        ),
                        StepsForm(
                          stepsNum: viewmodel.stepsNum,
                          stepController: viewmodel.stepsControllers,
                          addStepsButtonOnPressed:
                              viewmodel.addStepsButtonOnPressed,
                          removeStepsButtonOnPressed:
                              viewmodel.removeStepsButtonOnPressed,
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 10),
                          child: SizedBox(
                            width: 150,
                            child: ElevatedButton(
                                onPressed: () {
                                  if (viewmodel.formKey.currentState
                                      .validate()) {
                                    viewmodel.addRecipe(context);
                                  }
                                },
                                child: const Text('Add Recipe'),
                                style: ElevatedButton.styleFrom(
                                  primary: Color.fromRGBO(255, 178, 102, 1),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          );
        });
  }
}
