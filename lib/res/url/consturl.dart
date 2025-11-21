class ConstUrl {

  static const String baseUrl = "https://9m7kku3vtf.execute-api.ap-south-1.amazonaws.com/vender";


  /// Authentication Related Api
  static const String login = "$baseUrl/signup";

  static const String otpVerification = "$baseUrl/signup_otp_verification";

  /// Profile Related
  static const String profile = "$baseUrl/vender_get_profile?phone=";
  static const String document = "$baseUrl/vender_get_documents?phone=";

  static const String editProfile = "$baseUrl/edit_profile";

  static const String profileSetup = "$baseUrl/vender_profile_setup";

  static const String profileImagePresigned = "$baseUrl/vender_profile_image_presigned";

  static const String documentsImagePresigned = "$baseUrl/document_upload_presigned";

  static const String scheduleSkillTestAppointment = "$baseUrl/schedule_vender_skilltest_appointment";

  static const String cancelSkillTestAppointment = "$baseUrl/cancel_vender_skill_test_appointment";

  static const String reScheduleSkillTestAppointment = "$baseUrl/reschedule_vender_skill_test_appointment";

  static const String uploadDocuments = "$baseUrl/document_upload";

  static const String allCategory = "$baseUrl/vender_category_getAll";

  static const String getParticularCategorySkill = "$baseUrl/vender_getServices_ByCategory";


  /// Dashboard

  static const String getAppointmentList = "$baseUrl/vender_pending_bookings?venderPhone=";
  static const String particularAppointment = "$baseUrl/vender_particular_booking_details?id=";
  static const String acceptOrRejectAppointment = "$baseUrl/vender_accept_or_reject_bookings";
  static const String acceptOrRejectCount = "$baseUrl/vender_accepted_or_rejected_count?phone=";

  static const String sendStartServiceOTP = "$baseUrl/vender_send_start_service_otp";
  static const String resendStartServiceOTP = "$baseUrl/vender_resend_start_service_otp";
  static const String verifyStartServiceOTP = "$baseUrl/verify_start_service_otp";




  /// Default image Url
  static const String defaultImageUrl = '';
}