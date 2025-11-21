class AcceptAndRejectCountModel {
  final int approvedCount;
  final int rejectedCount;

  AcceptAndRejectCountModel({
    required this.approvedCount,
    required this.rejectedCount,
  });

  factory AcceptAndRejectCountModel.fromJson(Map<String, dynamic> json) {
    return AcceptAndRejectCountModel(
      approvedCount: json['approvedCount'],
      rejectedCount: json['rejectedCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'approvedCount': approvedCount,
      'rejectedCount': rejectedCount,
    };
  }
}
