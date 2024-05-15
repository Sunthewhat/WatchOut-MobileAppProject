class Report {
  final String incidentType;
  final String location;
  final String imageUrl;
  final String userName;
  final String reportDescription;
  final double range;
  final String reportTime;
  final String title;
  final double latitude;
  final double longitude;

  Report({
    required this.incidentType,
    required this.location,
    required this.imageUrl,
    required this.userName,
    required this.reportDescription,
    required this.range,
    required this.reportTime,
    required this.title,
    required this.latitude,
    required this.longitude,
  });
}