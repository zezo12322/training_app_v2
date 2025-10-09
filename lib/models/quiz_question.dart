import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'quiz_question.freezed.dart';
part 'quiz_question.g.dart';

/// Supported quiz question types
class QuizQuestionType {
  static const multipleChoice = 'multiple_choice';
  static const shortText = 'short_text';
  static const longText = 'long_text';
  static const matching = 'matching';
}

@freezed
class QuizQuestion with _$QuizQuestion {
  const QuizQuestion._();
  const factory QuizQuestion({
    required String id,
    required String quizId,
    required String questionText,
    required String type,
    List<String>? options,
    int? correctAnswerIndex,
    // Matching specific
    List<String>? leftItems,
    List<String>? rightItems,
    Map<String, int>?
    correctPairs, // key: left index (string), value: right index
    DateTime? createdAt,
  }) = _QuizQuestion;

  factory QuizQuestion.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;
    return QuizQuestion(
      id: doc.id,
      quizId: data['quizId'] as String,
      questionText: data['questionText'] as String,
      type: data['type'] as String? ?? QuizQuestionType.multipleChoice,
      options: (data['options'] as List?)?.map((e) => e.toString()).toList(),
      correctAnswerIndex: data['correctAnswerIndex'] is int
          ? data['correctAnswerIndex'] as int
          : null,
      leftItems: (data['leftItems'] as List?)
          ?.map((e) => e.toString())
          .toList(),
      rightItems: (data['rightItems'] as List?)
          ?.map((e) => e.toString())
          .toList(),
      correctPairs: (data['correctPairs'] as Map?)?.map(
        (k, v) => MapEntry(
          k.toString(),
          v is int ? v : int.tryParse(v.toString()) ?? -1,
        ),
      ),
      createdAt: (data['createdAt'] is Timestamp)
          ? (data['createdAt'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'quizId': quizId,
      'questionText': questionText,
      'type': type,
      if (options != null) 'options': options,
      if (correctAnswerIndex != null) 'correctAnswerIndex': correctAnswerIndex,
      if (leftItems != null) 'leftItems': leftItems,
      if (rightItems != null) 'rightItems': rightItems,
      if (correctPairs != null) 'correctPairs': correctPairs,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }

  factory QuizQuestion.fromJson(Map<String, dynamic> json) =>
      _$QuizQuestionFromJson(json);
}
