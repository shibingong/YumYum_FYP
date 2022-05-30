import 'dart:convert';
import 'dart:io';

import 'package:yumyumfyp/models/feedback.dart';

import '../../app/dependencies.dart';
import '../rest.dart';
import 'feedback_service.dart';

class FeedbackServiceRest implements FeedbackService {
  final rest = dependency<RestService>();

  Future<List<Feedbacks>> getFeedbackList(String recipeID) async {
    var jsonResult = await rest.get('feedback/' + recipeID);
    List<Feedbacks> feedbackList =
        (jsonResult as List).map((json) => Feedbacks.fromJson(json)).toList();
    return feedbackList;
  }

  Future<Feedbacks> addFeedback(
      String recipeID, String comment, String rating) async {
    final json = await rest.post('feedback/',
        data: {'recipeid': recipeID, 'comment': comment, 'rating': rating});
    return Feedbacks.fromJson(json);
  }
}
