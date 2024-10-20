class FortuneCategories {
  final int? id;
  final String categoryName;

  FortuneCategories({
    this.id,
    required this.categoryName,
  });

  factory FortuneCategories.fromJson(Map<String, dynamic> json) {
    return FortuneCategories(
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
