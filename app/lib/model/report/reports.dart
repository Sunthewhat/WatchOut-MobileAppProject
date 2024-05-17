import 'package:app/model/report/report.dart';

class GetAllReportResponse {
  final List<ReportResponse> reports;

  GetAllReportResponse({required this.reports});

  factory GetAllReportResponse.fromJson(List<dynamic> json) {
    List<ReportResponse> reports =
        json.map((reportJson) => ReportResponse.fromJson(reportJson)).toList();
    return GetAllReportResponse(reports: reports);
  }
}
