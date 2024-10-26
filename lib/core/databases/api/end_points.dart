class EndPoints {
  static const String baseUrl = 'https://api.evntown.site';
  static const String signUp = '/api/v1/auth/signup';
  static const String signIn = '/api/v1/auth/login';
  static const String forgetPassword = '/api/v1/auth/forgotPassword';
  static const String getCategories = '/api/v1/categories';
  static const String getTopEvents = '/api/v1/events/pro/topEvents';
  static const String getEvents = '/api/v1/events';
  static const String getUserData = '/api/v1/users/getMe';
  static const String changeUserData = '/api/v1/users/changeMyData';
  static const String createEvents = '/api/v1/events';
  static const String addToWishlist = '/api/v1/wishlists';
  static const String getWishlist = '/api/v1/wishlists';
  static const String addToCalendar = '/api/v1/calendars';
  static const String getCalendarEvents = '/api/v1/calendars';
  static const String createComment = '/api/v1/comments';
  static const String getInYourAreaEvents = '/api/v1/events/location/myArea';
  static const String getForYouEvents = '/api/v1/events/interests/forYou';
  static const String getWeekEvents = '/api/v1/events/date/thisWeek';
  static const String verfiyResetPassword = '/api/v1/auth/verifyResetCode';
  static const String resetPassword = '/api/v1/auth/resetPassword';
  static const String verfiyEmailCode = '/api/v1/auth/verifyEmailCode';
  static const String resendCode = '/api/v1/auth/resendCode';
  static const String deleteMyAccount = '/api/v1/users/deleteMyAccount';
  static const String changeMyPassword =
      '/api/v1/users/changeMyPassword';

  static removeFromWhishList(String id) {
    return '/api/v1/wishlists/$id';
  }

  static removeFromCalandar(String id) {
    return '/api/v1/calendars/$id';
  }

  static getEventsByCategory(String id) {
    return "/api/v1/categories/$id/events";
  }

  static getEventById(String id) {
    return "/api/v1/events/$id";
  }
}
