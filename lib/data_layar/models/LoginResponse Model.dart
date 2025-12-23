class LoginResponse {
  final int status;
  final String message;
  final Map<String, dynamic>? data;
  final String? token;

  LoginResponse({
    required this.status,
    required this.message,
    this.data,
    this.token,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json["status"] ?? 0,
      message: json["message"] is String
          ? json["message"]
          : json["message"].toString(),
      data: json["data"],
      token: json["token"],
    );
  }
}
