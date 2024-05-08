import 'package:app/constant/environment.dart';
import 'package:app/model/base_response.dart';
import 'package:dio/dio.dart';

class Register {
  static Future<BaseResponse<Object>> register(String firstname,
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
      var response = BaseResponse<Object>.fromJson(res.data, null);
      return response;
    } catch (e) {
      return BaseResponse<Object>(
        success: false,
        message: e.toString(),
      );
    }
  }
}
