class ConstUrl {

  static const String baseUrl = "https://xs3n0k5gbi.execute-api.ap-south-1.amazonaws.com/prod";


  /// Authentication Related Api
  static const String login = "$baseUrl/pharmacy_login";
  static const String register = "$baseUrl/usersSignup_ONE_APP";



  /// Common Api For Every Section
  static const String profile = "$baseUrl/pharmacy_MR_profile";

  static const String visitList = "$baseUrl/pharmacy_particular_MR_assign_visit_list";

  static const String particularVisit = "$baseUrl/pharmacy_particular_assign";


  static const String startVisit = "$baseUrl/pharmacy_MR_start_visit";
  static const String reachedVisit = "$baseUrl/pharmacy_MR_reached";
  static const String completeVisit = "$baseUrl/pharmacy_assign_visit_complete";


  /// Default image Url
  static const String defaultImageUrl = 'https://puja-app.s3.ap-south-1.amazonaws.com/products_image/IMG_4719845_VaidikaLogo.png';
}