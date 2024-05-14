class BaseResponse<T> {
  bool success;
  T? payload;
  String message;

  BaseResponse({
    required this.success,
    this.payload,
    required this.message,
  });

  factory BaseResponse.fromJson(
          Map<String, dynamic> json, Function(Map<String, dynamic>)? create) =>
      BaseResponse(
          success: json['success'],
          payload: create == null ? null : create(json['payload']),
          message: json['message']);

  factory BaseResponse.fromArrayJson(
    Map<String, dynamic> json,
    Function(List<dynamic>) create,
  ) =>
      BaseResponse(
          success: json['success'],
          payload: create(json['payload']),
          message: json['message']);
}
