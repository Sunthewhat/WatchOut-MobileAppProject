import 'package:app/constant/environment.dart';
import 'package:app/model/auth/register.dart';
import 'package:app/model/base_response.dart';
import 'package:dio/dio.dart';

class Register {
  static Future<BaseResponse<RegisterResponse>> register(String firstname,
      String lastname, String username, String password) async {
    try {
      Response res = await Dio().post(
        '${EnvironmentConstant.baseurl}/auth/register',
        data: {
          'firstname': firstname,
          'lastname': lastname,
          'username': username,
          'password': password,
        },
      );
      var response = BaseResponse<RegisterResponse>.fromJson(
          res.data, (payload) => RegisterResponse.fromJson(payload));
      return response;
    } catch (e) {
      return BaseResponse<RegisterResponse>(
        success: false,
        message: "Internal Server Error",
      );
    }
  }
}
