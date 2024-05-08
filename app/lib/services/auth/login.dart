import 'package:app/constant/environment.dart';
import 'package:app/model/auth/login.dart';
import 'package:app/model/base_response.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login {
  static Future<BaseResponse<LoginResponse>> login(
      String username, String password) async {
    try {
      Response res = await Dio().post(
        '${EnvironmentConstant.baseurl}/auth/login',
        data: {
          'username': username,
          'password': password,
        },
      );
      var response = BaseResponse<LoginResponse>.fromJson(
          res.data, (payload) => LoginResponse.fromJson(payload));
      if (response.success) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        await pref.setString(
            EnvironmentConstant.userToken, response.payload!.token);
      }
      return response;
    } catch (e) {
      return BaseResponse<LoginResponse>(
        success: false,
        message: 'Internal Server Error',
      );
    }
  }
}
