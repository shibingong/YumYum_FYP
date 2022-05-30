import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yumyumfyp/models/recipe.dart';
import 'package:yumyumfyp/screens/view_recipe_feedback/view_recipe_feedback_viewmodel.dart';
import 'package:yumyumfyp/widgets/recipe_nutrition_row.dart';

import '../../app/dependencies.dart';
import '../view.dart';

class ViewRecipeFeedbackScreen extends StatelessWidget {
  static const routeName = '/view_recipe_feedbacks';
  static MaterialPageRoute createRoute(args) => MaterialPageRoute(
      builder: (_) => ViewRecipeFeedbackScreen(args['recipe']));

  final Recipe recipe;
  ViewRecipeFeedbackScreen(this.recipe);

  @override
  Widget build(BuildContext context) {
    return ConsumerView(
        viewmodel: dependency<ViewRecipeFeedbackViewModel>()..getList(recipe),
        builder: (context, viewmodel, _) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Feedbacks",
                style: TextStyle(color: Colors.black),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              iconTheme: IconThemeData(color: Colors.black),
            ),
            backgroundColor: Color.fromRGBO(255, 229, 204, 1),
            body: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        viewmodel.averageRating.toString(),
                        style: TextStyle(fontSize: 50),
                      ),
                    ),
                    Center(
                      child: RatingBar.builder(
                        initialRating: viewmodel.averageRating,
                        ignoreGestures: true,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 30,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                          "Based on ${viewmodel.feedbacks.length} feeedback(s)"),
                    ),
                    Divider(),
                    (viewmodel.feedbacks.length != 0)
                        ? SingleChildScrollView(
                            child: ListView.builder(
                                physics: ClampingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: viewmodel.feedbacks.length,
                                itemBuilder: (BuildContext context,
                                        int index) =>
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      child: Card(
                                        color: Color.fromRGBO(255, 229, 204, 1),
                                        child: Column(
                                          children: [
                                            ListTile(
                                              leading: CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    viewmodel.feedbacks[index]
                                                        .user.profileImage),
                                                // backgroundImage: AssetImage('assets/images/user.png'),
                                              ),
                                              title: Text(viewmodel
                                                  .feedbacks[index].user.name),
                                              trailing: RatingBar.builder(
                                                initialRating: double.parse(
                                                    viewmodel.feedbacks[index]
                                                        .rating),
                                                ignoreGestures: true,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemCount: 5,
                                                itemSize: 20,
                                                itemPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 2.0),
                                                itemBuilder: (context, _) =>
                                                    Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                                onRatingUpdate: (rating) {
                                                  print(rating);
                                                },
                                              ),
                                            ),
                                            Container(
                                                height: 50,
                                                padding: EdgeInsets.fromLTRB(
                                                    20, 10, 20, 10),
                                                alignment: Alignment.centerLeft,
                                                child: Text(viewmodel
                                                    .feedbacks[index].comment)),
                                          ],
                                        ),
                                      ),
                                    )),
                          )
                        : Center(
                            child: Container(
                            padding: const EdgeInsets.only(top: 250),
                            // height: 500.0,
                            child: Text("No feedbacks given yet"),
                          ))
                  ],
                ),
              ),
            ),
            floatingActionButton: viewmodel.showFloatingButton
                ? FloatingActionButton.extended(
                    label: Text('Add Feedback'),
                    onPressed: () =>
                        viewmodel.onPressFloatButton(context, recipe),
                    icon: Icon(
                      Icons.add,
                      size: 35,
                      color: Colors.white,
                    ),
                    backgroundColor: Color.fromRGBO(255, 178, 102, 1),
                  )
                : null,
          );
        });
  }
}
