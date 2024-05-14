class GetAllReportResponse {
  final List<GetReportResponseType> reports;

  GetAllReportResponse({required this.reports});

  factory GetAllReportResponse.fromJson(List<dynamic> json) {
    List<GetReportResponseType> reports = json
        .map((reportJson) => GetReportResponseType.fromJson(reportJson))
        .toList();
    return GetAllReportResponse(reports: reports);
  }
}

class GetReportResponseType {
  int id;
  String title;
  String description;
  String image;
  String type;
  DateTime time;
  double latitude;
  double longitude;
  String user;
  String userImage;

  GetReportResponseType({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.type,
    required this.time,
    required this.latitude,
    required this.longitude,
    required this.user,
    required this.userImage,
  });

  factory GetReportResponseType.fromJson(Map<String, dynamic> json) {
    return GetReportResponseType(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      image: json['image'],
      type: json['type'],
      time: DateTime.parse(json['time']),
      latitude: double.parse(json['latitude']),
      longitude: double.parse(json['longitude']),
      user: json['user'],
      userImage: json['userImage'],
    );
  }
}
