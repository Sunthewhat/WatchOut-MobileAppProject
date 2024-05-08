class LoginResponse {
  int code;
  String token;

  LoginResponse({
    required this.code,
    required this.token,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      code: json['code'],
      token: json['token'],
    );
  }
}
