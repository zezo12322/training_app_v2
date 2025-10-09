import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_review.dart';

class ReviewRepository {
  final _reviewsRef = FirebaseFirestore.instance.collection('user_reviews');

  Future<void> addReview(UserReview review) async {
    await _reviewsRef.add(review.toMap());
  }

  Future<List<UserReview>> getReviewsForUser(String userId) async {
    final snapshot = await _reviewsRef
        .where('targetId', isEqualTo: userId)
        .get();
    return snapshot.docs.map((doc) => UserReview.fromFirestore(doc)).toList();
  }

  Future<double> getAverageRating(String userId) async {
    final reviews = await getReviewsForUser(userId);
    if (reviews.isEmpty) return 0.0;
    final total = reviews.fold<double>(0.0, (acc, r) => acc + r.rating);
    return total / reviews.length;
  }
}
