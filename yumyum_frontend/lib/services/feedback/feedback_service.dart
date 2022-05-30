import 'dart:io';

import 'package:yumyumfyp/models/feedback.dart';

abstract class FeedbackService {
  Future<List<Feedbacks>> getFeedbackList(String recipeID);
  Future<Feedbacks> addFeedback(String recipeID, String comment, String rating);
}
