class ErrorModel {
  final String detail;
  //here will be the error model from the server
  ErrorModel({required this.detail});
  factory ErrorModel.fromJson(Map<String, dynamic> jsonData) {
    return ErrorModel(
      detail: jsonData['message'] ?? "Something went wrong",
    );
  }
}
