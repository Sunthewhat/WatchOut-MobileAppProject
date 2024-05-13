import 'package:app/constant/environment.dart';
import 'package:app/model/base_response.dart';
import 'package:app/model/report/report.dart';
import 'package:app/model/report/reports.dart';
import 'package:dio/dio.dart';

class ReportService {
  static Future<BaseResponse<ReportResponse>> createReport(
      int id,
      int imageId,
      int userId,
      String title,
      String description,
      String type,
      DateTime time,
      double latitude,
      double longitude) async {
    try {
      Response res = await Dio().post(
        '${EnvironmentConstant.baseurl}/report/create',
        data: {
          'id': id,
          'imageId': imageId,
          'userId': userId,
          'title': title,
          'description': description,
          'type': type,
          'time': time,
          'latitude': latitude,
          'longitude': longitude,
        },
      );
      var response = BaseResponse<ReportResponse>.fromJson(
        res.data,
        (payload) => ReportResponse.fromJson(payload),
      );
      return response;
    } catch (e) {
      return BaseResponse<ReportResponse>(
        success: false,
        message: e.toString(),
        payload: ReportResponse(
          id: 0,
          imageId: 0,
          userId: 0,
          title: '',
          description: '',
          type: '',
          time: DateTime.now(),
          latitude: 0,
          longitude: 0,
        ),
      );
    }
  }

  static Future<BaseResponse<GetAllReportResponse>> getAllReports() async {
    try {
      Response res = await Dio().get('${EnvironmentConstant.baseurl}/report/');
      // print(res.data);
      var response = BaseResponse<GetAllReportResponse>.fromArrayJson(
        res.data,
        (payload) => GetAllReportResponse.fromJson(payload),
      );
      return response;
    } catch (e) {
      return BaseResponse<GetAllReportResponse>(
        success: false,
        message: e.toString(),
        payload: GetAllReportResponse(
          reports: [],
        ),
      );
    }
  }
}
