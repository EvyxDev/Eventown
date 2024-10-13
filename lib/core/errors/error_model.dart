class ErrorModel {
  final dynamic detail;
  //here will be the error model from the server
  ErrorModel({required this.detail});
  factory ErrorModel.fromJson(Map<String, dynamic> jsonData) {
    return ErrorModel(
      detail: jsonData,
    );
  }
}
