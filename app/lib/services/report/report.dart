import 'dart:io';
import 'package:app/constant/environment.dart';
import 'package:app/model/base_response.dart';
import 'package:app/model/report/reports.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReportService {
  static Future<BaseResponse<Null>> createReport(
      File image,
      String title,
      String description,
      String type,
      double latitude,
      double longitude,
      String date) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString(EnvironmentConstant.userToken);
      FormData data = FormData.fromMap({
        'file': await MultipartFile.fromFile(image.path,
            filename: image.path.split('/').last),
        'token': token!,
        'title': title,
        'description': description,
        'type': type,
        'latitude': latitude,
        'longitude': longitude,
        'date': date,
      });
      Response res = await Dio().post(
        '${EnvironmentConstant.baseurl}/report/create',
        data: data,
      );
      var response = BaseResponse<Null>.fromJson(res.data, null);
      return response;
    } catch (e) {
      return BaseResponse<Null>(
        success: false,
        message: e.toString(),
        payload: null,
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

  static Future<BaseResponse<GetAllReportResponse>> getUserReports() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString(EnvironmentConstant.userToken);
      if (token == null) {
        throw Exception('Token not found');
      }
      Response res = await Dio()
          .get('${EnvironmentConstant.baseurl}/report/user?token=$token');
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
