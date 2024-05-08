class RegisterResponse {
  int code;

  RegisterResponse({
    required this.code,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      code: json['code'],
    );
  }
}
