import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:yumyumfyp/models/recipe.dart';

import '../../app/dependencies.dart';
import '../../widgets/custom_text_field.dart';
import '../view.dart';
import 'add_recipe_feedback_viewmodel.dart';

class AddRecipeFeedbackScreen extends StatelessWidget {
  static const routeName = '/add_recipe_feedback';
  static MaterialPageRoute createRoute(args) => MaterialPageRoute(
      builder: (_) => AddRecipeFeedbackScreen(args['recipe']));

  final Recipe recipe;
  AddRecipeFeedbackScreen(this.recipe);

  @override
  Widget build(BuildContext context) {
    return ConsumerView(
        viewmodel: dependency<AddRecipeFeedbackViewModel>()..init(recipe),
        builder: (context, viewmodel, _) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "New Feedback",
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
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
                          child: Text(
                            "Rating for ${recipe.recipeName}",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 30, 10, 30),
                          child: RatingBar.builder(
                            initialRating: 3,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              viewmodel.setRating(rating);
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 29, right: 29, top: 5),
                          child: Container(
                            height: 60,
                            child: CustomTextField(
                              hintText: 'Comment',
                              obscured: false,
                              controller: viewmodel.commentController,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 10),
                          child: SizedBox(
                            width: 150,
                            child: ElevatedButton(
                                onPressed: () {
                                  if (viewmodel.formKey.currentState
                                      .validate()) {
                                    viewmodel.addFeedback(context);
                                  }
                                },
                                child: const Text('Add Feedback'),
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
