class ProfileModel {
  final bool isAvailable;
  final String? loginOtp;
  final String location;
  final String createdAt;
  final bool accountVerified;
  final String otp;
  final String name;
  final String updatedAt;
  final String profileImage;
  final String login;
  final int tstamp;
  final String role;
  final String lastAvailable;
  final List<String> skills;
  final int pk; // fixed: int instead of String
  final String phone;

  ProfileModel({
    required this.isAvailable,
    this.loginOtp,
    required this.location,
    required this.createdAt,
    required this.accountVerified,
    required this.otp,
    required this.name,
    required this.updatedAt,
    required this.profileImage,
    required this.login,
    required this.tstamp,
    required this.role,
    required this.lastAvailable,
    required this.skills,
    required this.pk,
    required this.phone,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      isAvailable: json['isavailable'] ?? false,
      loginOtp: json['login_otp'], // might be null
      location: json['location'] ?? '',
      createdAt: json['created_at'] ?? '',
      accountVerified: json['account_verified'] ?? false,
      otp: json['otp'] ?? '',
      name: json['name'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      profileImage: json['profile_image'] ?? '',
      login: json['login'] ?? '',
      tstamp: json['tstamp'] ?? 0,
      role: json['role'] ?? '',
      lastAvailable: json['lastAvailable']?.toString() ?? 'N/A', // safe
      skills: List<String>.from(json['skills'] ?? []),
      pk: json['pk'] is int ? json['pk'] : int.tryParse(json['pk'].toString()) ?? 0,
      phone: json['phone']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isavailable': isAvailable,
      'login_otp': loginOtp,
      'location': location,
      'created_at': createdAt,
      'account_verified': accountVerified,
      'otp': otp,
      'name': name,
      'updated_at': updatedAt,
      'profile_image': profileImage,
      'login': login,
      'tstamp': tstamp,
      'role': role,
      'lastAvailable': lastAvailable,
      'skills': skills,
      'pk': pk,
      'phone': phone,
    };
  }
}
