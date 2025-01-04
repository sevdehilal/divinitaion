class FortuneTopic {
  final int? id;
  final String categoryName;

  FortuneTopic({
    this.id,
    required this.categoryName,
  });

  factory FortuneTopic.fromJson(Map<String, dynamic> json) {
    return FortuneTopic(
      id: json['id'],
      categoryName: json['categoryName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categoryName': categoryName,
    };
  }
}
