class ScheduledResponseModel<T> {
  final int status;
  final T data;
  final String? message;

  ScheduledResponseModel({
    required this.status,
    required this.data,
    this.message,
  });

  factory ScheduledResponseModel.fromJson(
      Map<String, dynamic> json,
      T Function(dynamic json) fromJsonT,
      ) {
    return ScheduledResponseModel<T>(
      status: json['status'],
      data: fromJsonT(json['data']),
      message: json['message'],
    );
  }
}
