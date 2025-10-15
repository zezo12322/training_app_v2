import 'package:freezed_annotation/freezed_annotation.dart';
import '../core/timestamp_converter.dart';

part 'message_reaction.freezed.dart';
part 'message_reaction.g.dart';

/// تفاعل على رسالة (Emoji)
@freezed
class MessageReaction with _$MessageReaction {
  const factory MessageReaction({
    required String emoji,
    required String userId,
    required String userName,
    @TimestampConverter() required DateTime createdAt,
  }) = _MessageReaction;

  factory MessageReaction.fromJson(Map<String, dynamic> json) =>
      _$MessageReactionFromJson(json);
}

/// ملخص التفاعلات على رسالة
@freezed
class ReactionSummary with _$ReactionSummary {
  const factory ReactionSummary({
    /// Map من emoji -> عدد التفاعلات
    @Default({}) Map<String, int> counts,
    
    /// Map من emoji -> قائمة أسماء المستخدمين
    @Default({}) Map<String, List<String>> userNames,
    
    /// هل تفاعل المستخدم الحالي؟ (emoji -> bool)
    @Default({}) Map<String, bool> currentUserReactions,
    
    /// إجمالي التفاعلات
    @Default(0) int totalCount,
  }) = _ReactionSummary;

  factory ReactionSummary.fromJson(Map<String, dynamic> json) =>
      _$ReactionSummaryFromJson(json);
}

/// Emoji شائعة للاستخدام السريع
class PopularEmojis {
  static const List<String> list = [
    '👍', // إعجاب
    '❤️', // حب
    '😂', // ضحك
    '😮', // مفاجأة
    '😢', // حزن
    '🎉', // احتفال
    '🔥', // نار
    '👏', // تصفيق
    '🤔', // تفكير
    '✅', // صح
  ];
}
