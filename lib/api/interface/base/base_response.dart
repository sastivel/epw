class BaseResponse<T> {
  final T? data;
  final String? message;
  final String? error;
  final int? statusCode;

  BaseResponse({this.data, this.error, this.message, this.statusCode});

  BaseResponse.fromJson(Map<String, dynamic> json)
      : data = json['data'] as T,
        error = json['error'] as String?,
        statusCode = json['statusCode'] as int?,
        message = json['msg'] as String?;

  Map<String, dynamic> toJson() => {
        'data': data,
        'error': error,
        'message': message,
        'statusCode': statusCode
      };
}
