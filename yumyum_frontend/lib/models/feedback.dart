import 'package:flutter/foundation.dart';
import 'package:yumyumfyp/models/recipe.dart';
import 'package:yumyumfyp/models/user.dart';

class Feedbacks {
  String feedbackId;
  String comment;
  String rating;
  User user;
  // Recipe recipe;

  Feedbacks({
    @required this.feedbackId,
    @required this.comment,
    @required this.rating,
    @required this.user,
    // @required this.recipe,
  });

  Feedbacks.fromJson(Map<String, dynamic> json)
      : this(
          feedbackId: json['_id'],
          comment: json['comment'],
          rating: json['rating'],
          user:  User.fromJson(json['userID']),
          // recipe: Recipe.fromJson(json['recipeID']),
        );

  Map<String, dynamic> toJson() => {
        '_id': feedbackId,
        'comment': comment,
        'rating': rating,
        'userID': user,
        // 'recipeID': recipe,
      };
}
