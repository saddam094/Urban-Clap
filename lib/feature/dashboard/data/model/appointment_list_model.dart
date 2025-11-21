class AppointmentListModel {
  final String message;
  final List<Booking> bookings;

  AppointmentListModel({
    required this.message,
    required this.bookings,
  });

  factory AppointmentListModel.fromJson(Map<String, dynamic> json) {
    return AppointmentListModel(
      message: json['message'],
      bookings: List<Booking>.from(
        json['bookings'].map((x) => Booking.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'bookings': List<dynamic>.from(bookings.map((x) => x.toJson())),
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
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      serviceName: json['serviceName'],
      location: json['location'],
      totalAmount: json['totalAmount'],
      checkoutTime: json['checkoutTime'],
      userName: json['userName'],
      time: json['time'],
      isApproved: json['is_approved'],
      checkoutDay: json['checkoutDay'],
      userPhone: json['userPhone'],
      checkoutYear: json['checkoutYear'],
      landmark: Landmark.fromJson(json['landmark']),
      date: json['date'],
      note: json['note'],
      venderPhone: json['venderPhone'],
      tstamp: json['tstamp'],
      bookingStatus: json['booking_status'],
      checkoutMonth: json['checkoutMonth'],
      month: json['month'],
      year: json['year'],
      serviceId: json['serviceId'],
      day: json['day'],
      id: json['id'],
      pk: json['pk'],
      duration: json['duration'],
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
      longitude: json['longitude'],
      latitude: json['latitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'longitude': longitude,
      'latitude': latitude,
    };
  }
}
