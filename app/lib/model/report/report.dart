class ReportResponse {
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

  ReportResponse({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.time,
    required this.latitude,
    required this.longitude,
    required this.user,
    required this.userImage,
    required this.image,
  });

  factory ReportResponse.fromJson(Map<String, dynamic> json) {
    return ReportResponse(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      type: json['type'],
      time: DateTime.parse(json['time']),
      latitude: double.parse(json['latitude']),
      longitude: double.parse(json['longitude']),
      user: json['user'],
      userImage: json['user_image'],
      image: json['image'],
    );
  }
}
