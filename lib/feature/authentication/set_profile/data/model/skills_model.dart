class SkillsModel {
  final String message;
  final int count;
  final List<ServiceData> data;

  SkillsModel({
    required this.message,
    required this.count,
    required this.data,
  });

  factory SkillsModel.fromJson(Map<String, dynamic> json) {
    return SkillsModel(
      message: json['message'],
      count: json['count'],
      data: List<ServiceData>.from(
        json['data'].map((item) => ServiceData.fromJson(item)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'count': count,
      'data': List<dynamic>.from(data.map((x) => x.toJson())),
    };
  }
}

class ServiceData {
  final String serviceName;
  final String defaultPrice;
  final String status;
  final String createdAt;
  final String updatedBy;
  final String createdBy;
  final int tstamp;
  final String image;
  final String updatedAt;
  final String category;
  final String id;
  final String pk;
  final String customPrice;
  final String duration;

  ServiceData({
    required this.serviceName,
    required this.defaultPrice,
    required this.status,
    required this.createdAt,
    required this.updatedBy,
    required this.createdBy,
    required this.tstamp,
    required this.image,
    required this.updatedAt,
    required this.category,
    required this.id,
    required this.pk,
    required this.customPrice,
    required this.duration,
  });

  factory ServiceData.fromJson(Map<String, dynamic> json) {
    return ServiceData(
      serviceName: json['serviceName'],
      defaultPrice: json['defaultPrice'],
      status: json['status'],
      createdAt: json['createdAt'],
      updatedBy: json['updatedBy'],
      createdBy: json['createdBy'],
      tstamp: json['tstamp'],
      image: json['image'],
      updatedAt: json['updatedAt'],
      category: json['category'],
      id: json['id'],
      pk: json['pk'],
      customPrice: json['customPrice'],
      duration: json['duration'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'serviceName': serviceName,
      'defaultPrice': defaultPrice,
      'status': status,
      'createdAt': createdAt,
      'updatedBy': updatedBy,
      'createdBy': createdBy,
      'tstamp': tstamp,
      'image': image,
      'updatedAt': updatedAt,
      'category': category,
      'id': id,
      'pk': pk,
      'customPrice': customPrice,
      'duration': duration,
    };
  }
}
