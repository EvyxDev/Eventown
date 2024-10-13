class EndPoints {
  static const String baseUrl = "https://clincher.evyx.xyz/";

  static String getLawyerDetails(String id) {
    return "public/api/lawyer/$id";
  }
}
