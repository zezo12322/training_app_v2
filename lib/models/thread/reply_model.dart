import 'package:cloud_firestore/cloud_firestore.dart';

enum ReplyType { text, audio }

class ReplyModel {
  final String id;
  final String authorId;
  final ReplyType type;
  final String? text;
  final String? audioUrl;
  final int? audioDurationSec;
  final DateTime? createdAt;
  final DateTime? editedAt;
  final DateTime? canEditUntil;
  final DateTime? deletableUntil;

  ReplyModel({
    required this.id,
    required this.authorId,
    required this.type,
    this.text,
    this.audioUrl,
    this.audioDurationSec,
    this.createdAt,
    this.editedAt,
    this.canEditUntil,
    this.deletableUntil,
  });

  factory ReplyModel.fromMap(Map<String, dynamic> map, {required String id}) {
    return ReplyModel(
      id: id,
      authorId: map['authorId'] ?? '',
      type: (map['type'] == 'audio') ? ReplyType.audio : ReplyType.text,
      text: map['text'] as String?,
      audioUrl: map['audioUrl'] as String?,
      audioDurationSec: map['audioDurationSec'] as int?,
      createdAt: _ts(map['createdAt']),
      editedAt: _ts(map['editedAt']),
      canEditUntil: _ts(map['canEditUntil']),
      deletableUntil: _ts(map['deletableUntil']),
    );
  }

  static DateTime? _ts(dynamic v) {
    if (v == null) return null;
    if (v is Timestamp) return v.toDate();
    if (v is DateTime) return v;
    return null;
  }

  factory ReplyModel.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) =>
      ReplyModel.fromMap(doc.data() ?? {}, id: doc.id);

  Map<String, dynamic> toMap() => {
    'authorId': authorId,
    'type': type == ReplyType.audio ? 'audio' : 'text',
    'text': text,
    'audioUrl': audioUrl,
    'audioDurationSec': audioDurationSec,
    'createdAt': createdAt,
    'editedAt': editedAt,
    'canEditUntil': canEditUntil,
    'deletableUntil': deletableUntil,
  };
}
