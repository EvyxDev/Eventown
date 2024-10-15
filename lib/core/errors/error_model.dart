class ErrorModel {
  final String detail;
  //here will be the error model from the server
  ErrorModel({required this.detail});
  factory ErrorModel.fromJson(Map<String, dynamic> jsonData) {
    // Check if the response contains errors
    if (jsonData.containsKey('errors')) {
      List<String> errorMessages = [];
      for (var error in jsonData['errors']) {
        errorMessages.add(error['msg']);
      }
      if (errorMessages.isNotEmpty) {
        return ErrorModel(
          detail: errorMessages[0],
        );
      } else {
        return ErrorModel(
          detail: jsonData['message'] ?? "Something went wrong",
        );
      }
    } else {
      return ErrorModel(
        detail: jsonData['message'] ?? "Something went wrong",
      );
    }
  }
}
