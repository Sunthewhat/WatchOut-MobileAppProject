import 'package:app/constant/environment.dart';
import 'package:app/model/base_response.dart';
import 'package:dio/dio.dart';

class Verify {
  static Future<BaseResponse<Null>> verify(String token) async {
    try {
      Response res = await Dio().post(
        '${EnvironmentConstant.baseurl}/auth/verify',
        data: {
          'token': token,
        },
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
