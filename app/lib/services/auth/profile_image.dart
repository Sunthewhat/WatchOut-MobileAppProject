import 'dart:io';
import 'package:app/constant/environment.dart';
import 'package:app/model/base_response.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileImage {
  static Future<BaseResponse<Null>> changeProfileImage(File image) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString(EnvironmentConstant.userToken);
      FormData data = FormData.fromMap({
        'file': await MultipartFile.fromFile(image.path, filename: image.path.split('/').last),
        'token': token!,
      });
      Response res = await Dio().put(
        '${EnvironmentConstant.baseurl}/image/profile',
        data: data,
      );
      var response = BaseResponse<Null>.fromJson(
        res.data,
        null,
      );
      return response;
    } catch (e) {
      return BaseResponse<Null>(
        success: false,
        message: 'Internal Server Error',
      );
    }
  }
}
