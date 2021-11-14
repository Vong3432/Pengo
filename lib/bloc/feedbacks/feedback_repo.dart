import 'package:pengo/bloc/feedbacks/feedback_api_provider.dart';
import 'package:pengo/models/response_model.dart';

class FeedbackRepo {
  factory FeedbackRepo() {
    return _instance;
  }

  FeedbackRepo._constructor();

  static final FeedbackRepo _instance = FeedbackRepo._constructor();
  final FeedbackApiProvider _feedbackApiProvider = FeedbackApiProvider();

  Future<ResponseModel> postReview(
    String title,
    String category,
    String description,
    int recordId,
  ) async =>
      _feedbackApiProvider.postReview(
        title,
        category,
        description,
        recordId,
      );
}
