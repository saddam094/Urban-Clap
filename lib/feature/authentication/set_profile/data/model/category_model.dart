class CategoryModel {
  final String message;
  final List<CategoryItem> items;

  CategoryModel({
    required this.message,
    required this.items,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      message: json['message'],
      items: List<CategoryItem>.from(
        json['items'].map((item) => CategoryItem.fromJson(item)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'items': List<dynamic>.from(items.map((x) => x.toJson())),
    };
  }
}

class CategoryItem {
  final String updatedAt;
  final String status;
  final String category;
  final String createdAt;
  final String updatedBy;
  final String pk;
  final String id;
  final String createdBy;
  final int tstamp;

  CategoryItem({
    required this.updatedAt,
    required this.status,
    required this.category,
    required this.createdAt,
    required this.updatedBy,
    required this.pk,
    required this.id,
    required this.createdBy,
    required this.tstamp,
  });

  factory CategoryItem.fromJson(Map<String, dynamic> json) {
    return CategoryItem(
      updatedAt: json['updatedAt'],
      status: json['status'],
      category: json['category'],
      createdAt: json['createdAt'],
      updatedBy: json['updatedBy'],
      pk: json['pk'],
      id: json['id'],
      createdBy: json['createdBy'],
      tstamp: json['tstamp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'updatedAt': updatedAt,
      'status': status,
      'category': category,
      'createdAt': createdAt,
      'updatedBy': updatedBy,
      'pk': pk,
      'id': id,
      'createdBy': createdBy,
      'tstamp': tstamp,
    };
  }
}
