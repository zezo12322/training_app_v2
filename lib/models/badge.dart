class Badge {
  final String id;
  final String name;
  final String description;
  final String iconUrl;
  final bool active;
  final bool autoAward; // if false => manual award only (future use)
  final Map<String, dynamic>
  criteria; // e.g. { pointsGte: 500, quizzesPassedGte: 3 }

  Badge({
    required this.id,
    required this.name,
    required this.description,
    required this.iconUrl,
    required this.active,
    required this.autoAward,
    required this.criteria,
  });

  factory Badge.fromMap(Map<String, dynamic> data, String id) {
    return Badge(
      id: id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      iconUrl: data['iconUrl'] ?? '',
      active: (data['active'] ?? true) == true,
      autoAward: (data['autoAward'] ?? true) == true,
      criteria: Map<String, dynamic>.from(data['criteria'] ?? const {}),
    );
  }

  Map<String, dynamic> toMap() => {
    'name': name,
    'description': description,
    'iconUrl': iconUrl,
    'active': active,
    'autoAward': autoAward,
    'criteria': criteria,
  };
}
