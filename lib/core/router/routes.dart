abstract final class AppRoutes {
  static const String signIn = '/sign-in';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String myRequests = '/my-requests';
  static const String createRequest = '/requests/new';
  static const String requestDetail = '/requests/:id';
  static const String nearbyDonors = '/requests/:id/donors';

  static String requestDetailPath(String id) => '/requests/$id';
  static String nearbyDonorsPath(String id) => '/requests/$id/donors';
}