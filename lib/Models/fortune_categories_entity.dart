class FortuneCategory {
  final int? id;
  final String categoryName;

  FortuneCategory({
    this.id,
    required this.categoryName,
  });

  factory FortuneCategory.fromJson(Map<String, dynamic> json) {
    return FortuneCategory(
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
