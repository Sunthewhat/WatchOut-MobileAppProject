import 'package:app/constant/environment.dart';
import 'package:app/model/auth/user.dart';
import 'package:app/model/base_response.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  static Future<BaseResponse<UserResponse>> getUser() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String token = pref.getString(EnvironmentConstant.userToken)!;
      Response res = await Dio()
          .get('${EnvironmentConstant.baseurl}/auth/user?token=$token');
      var response = BaseResponse<UserResponse>.fromJson(
          res.data, (payload) => UserResponse.fromJson(payload));
      pref.setString(EnvironmentConstant.userProfile, response.payload!.image);
      return response;
    } catch (e) {
      return BaseResponse<UserResponse>(
        success: false,
        message: 'Internal Server Error',
      );
    }
  }
}
