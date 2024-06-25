class BaseApiResponse {
  final dynamic data;
  final bool? error;
  final String? message;

  BaseApiResponse({
    this.data,
    this.error,
    this.message,
  });

  BaseApiResponse.fromJson(Map<String, dynamic> json)
      : data = json['data'] as dynamic,
        error = json['error'] as bool?,
        message = json['message'] as String?;

  Map<String, dynamic> toJson() =>
      {'data': data, 'error': error, 'message': message};
}
