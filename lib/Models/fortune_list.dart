class FortuneListt {
  final int? id;
  final String? fortunetellerFirstName;
  final String? fortunetellerLastName;
  final String? answer;
  final DateTime? createDate;
  final List<String>? categories;
  final double? score;

  FortuneListt({
    this.id,
    this.fortunetellerFirstName,
    this.fortunetellerLastName,
    this.answer,
    this.createDate,
    this.categories,
    this.score,
  });

  factory FortuneListt.fromJson(Map<String, dynamic> json) {
    List<String>? categoriesList;
    if (json['categories'] != null) {
      categoriesList = List<String>.from(json['categories']);
    }

    return FortuneListt(
      id: json['id'] as int?,
      fortunetellerFirstName: json['fortunetellerFirstName'] as String?,
      fortunetellerLastName: json['fortunetellerLastName'] as String?,
      answer: json['answer'] as String?,
      createDate: json['createDate'] != null
          ? DateTime.parse(json['createDate'])
          : null,
      categories: categoriesList,
      score: json['score'] as double?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fortunetellerFirstName': fortunetellerFirstName,
      'fortunetellerLastName': fortunetellerLastName,
      'answer': answer,
      'createDate': createDate?.toIso8601String(),
      'categories': categories,
      'score': score,
    };
  }
}
