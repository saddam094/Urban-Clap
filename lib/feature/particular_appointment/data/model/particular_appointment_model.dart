class ParticularAppointmentModel {
  final String message;
  final Booking booking;

  ParticularAppointmentModel({
    required this.message,
    required this.booking,
  });

  factory ParticularAppointmentModel.fromJson(Map<String, dynamic> json) {
    return ParticularAppointmentModel(
      message: json['message'] ?? '',
      booking: Booking.fromJson(json['booking'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'booking': booking.toJson(),
    };
  }
}

class Booking {
  final String serviceName;
  final String location;
  final int totalAmount;
  final String checkoutTime;
  final String userName;
  final String time;
  final bool isApproved;
  final int checkoutDay;
  final String userPhone;
  final int checkoutYear;
  final Landmark landmark;
  final String date;
  final String note;
  final String venderPhone;
  final int tstamp;
  final String bookingStatus;
  final int checkoutMonth;
  final int month;
  final int year;
  final String serviceId;
  final int day;
  final String id;
  final String pk;
  final String duration;
  final String otpExpiry;
  final bool otpVerified;

  Booking({
    required this.serviceName,
    required this.location,
    required this.totalAmount,
    required this.checkoutTime,
    required this.userName,
    required this.time,
    required this.isApproved,
    required this.checkoutDay,
    required this.userPhone,
    required this.checkoutYear,
    required this.landmark,
    required this.date,
    required this.note,
    required this.venderPhone,
    required this.tstamp,
    required this.bookingStatus,
    required this.checkoutMonth,
    required this.month,
    required this.year,
    required this.serviceId,
    required this.day,
    required this.id,
    required this.pk,
    required this.duration,
    required this.otpExpiry,
    required this.otpVerified,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      serviceName: json['serviceName'] ?? '',
      location: json['location'] ?? '',
      totalAmount: json['totalAmount'] ?? 0,
      checkoutTime: json['checkoutTime'] ?? '',
      userName: json['userName'] ?? '',
      time: json['time'] ?? '',
      isApproved: json['is_approved'] ?? false,
      checkoutDay: json['checkoutDay'] ?? 0,
      userPhone: json['userPhone']?.toString() ?? '',
      checkoutYear: json['checkoutYear'] ?? 0,
      landmark: Landmark.fromJson(json['landmark'] ?? {}),
      date: json['date'] ?? '',
      note: json['note'] ?? '',
      venderPhone: json['venderPhone']?.toString() ?? '',
      tstamp: json['tstamp'] ?? 0,
      bookingStatus: json['booking_status'] ?? '',
      checkoutMonth: json['checkoutMonth'] ?? 0,
      month: json['month'] ?? 0,
      year: json['year'] ?? 0,
      serviceId: json['serviceId'] ?? '',
      day: json['day'] ?? 0,
      id: json['id'] ?? '',
      pk: json['pk']?.toString() ?? '',
      duration: json['duration'] ?? '',
      otpExpiry: json['otpExpiry']?.toString() ?? '',
      otpVerified: json['otpVerified'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'serviceName': serviceName,
      'location': location,
      'totalAmount': totalAmount,
      'checkoutTime': checkoutTime,
      'userName': userName,
      'time': time,
      'is_approved': isApproved,
      'checkoutDay': checkoutDay,
      'userPhone': userPhone,
      'checkoutYear': checkoutYear,
      'landmark': landmark.toJson(),
      'date': date,
      'note': note,
      'venderPhone': venderPhone,
      'tstamp': tstamp,
      'booking_status': bookingStatus,
      'checkoutMonth': checkoutMonth,
      'month': month,
      'year': year,
      'serviceId': serviceId,
      'day': day,
      'id': id,
      'pk': pk,
      'duration': duration,
      'otpExpiry': otpExpiry,
      'otpVerified': otpVerified,
    };
  }
}

class Landmark {
  final String longitude;
  final String latitude;

  Landmark({
    required this.longitude,
    required this.latitude,
  });

  factory Landmark.fromJson(Map<String, dynamic> json) {
    return Landmark(
      longitude: json['longitude']?.toString() ?? '',
      latitude: json['latitude']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'longitude': longitude,
      'latitude': latitude,
    };
  }
}
