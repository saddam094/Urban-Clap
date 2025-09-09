class ConstUrl {

  static const String baseUrl = "https://9m7kku3vtf.execute-api.ap-south-1.amazonaws.com/vender";


  /// Authentication Related Api
  static const String login = "$baseUrl/signup";

  static const String otpVerification = "$baseUrl/signup_otp_verification";

  /// Profile Related
  static const String profile = "$baseUrl/vender_get_profile?phone=";

  static const String editProfile = "$baseUrl/edit_profile";

  static const String profileSetup = "$baseUrl/vender_profile_setup";

  static const String profileImagePresigned = "$baseUrl/vender_profile_image_presigned";


  /// Default image Url
  static const String defaultImageUrl = '';
}