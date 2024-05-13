class ReportResponse {
  int id;
  int imageId;
  int userId;
  String title;
  String description;
  String type;
  DateTime time;
  double latitude;
  double longitude;

  ReportResponse({
    required this.id,
    required this.imageId,
    required this.userId,
    required this.title,
    required this.description,
    required this.type,
    required this.time,
    required this.latitude,
    required this.longitude,
  });

  factory ReportResponse.fromJson(Map<String, dynamic> json) {
    return ReportResponse(
      id: json['id'],
      imageId: json['imageId'],
      userId: json['userId'],
      title: json['title'],
      description: json['description'],
      type: json['type'],
      time: DateTime.parse(json['time']),
      latitude: double.parse(json['latitude']),
      longitude: double.parse(json['longitude']),
    );
  }
}
