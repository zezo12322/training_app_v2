import 'package:cloud_firestore/cloud_firestore.dart';

class UserReview {
  final String id;
  final String reviewerId;
  final String targetId;
  final double rating;
  final String comment;
  final DateTime date;

  UserReview({
    required this.id,
    required this.reviewerId,
    required this.targetId,
    required this.rating,
    required this.comment,
    required this.date,
  });

  factory UserReview.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserReview(
      id: doc.id,
      reviewerId: data['reviewerId'] ?? '',
      targetId: data['targetId'] ?? '',
      rating: (data['rating'] ?? 0).toDouble(),
      comment: data['comment'] ?? '',
      date: (data['date'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() => {
    'reviewerId': reviewerId,
    'targetId': targetId,
    'rating': rating,
    'comment': comment,
    'date': Timestamp.fromDate(date),
  };
}
