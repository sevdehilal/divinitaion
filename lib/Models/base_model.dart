class BaseModel {
  bool success;
  String message;
  dynamic data;

  BaseModel({
    required this.success,
    required this.message,
    this.data,
  });

  BaseModel fromJson(Map<String, dynamic> json) {
    return BaseModel(
      success: json['success'],
      message: json['message'],
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data,
    };
  }
}
