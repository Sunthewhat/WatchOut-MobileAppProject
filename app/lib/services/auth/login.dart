import 'package:app/constant/environment.dart';
import 'package:app/model/auth/login.dart';
import 'package:app/model/base_response.dart';
import 'package:dio/dio.dart';

class Login {
  static Future<BaseResponse<LoginResponse>> login(
      String username, String password) async {
    try {
      Response res = await Dio().post(
        '${EnvironmentConstant.baseurl}/auth/login',
        data: {
          username,
          password,
        },
      );
      var response = BaseResponse<LoginResponse>.fromJson(
          res.data, (payload) => LoginResponse.fromJson(payload));
      return response;
    } catch (e) {
      return BaseResponse<LoginResponse>(
        success: false,
        message: 'Internal Server Error',
      );
    }
  }
}
