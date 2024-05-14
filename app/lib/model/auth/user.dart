class UserResponse {
  String name;
  String image;

  UserResponse({
    required this.name,
    required this.image,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      name: json['name'],
      image: json['image'],
    );
  }
}
