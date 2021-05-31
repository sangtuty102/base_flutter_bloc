//Base response

class BaseResponse<T> {
  int status;
  String message;
  T data;

  BaseResponse({
    this.status,
    this.message,
    this.data,
  });

  /// [data] hàm trả về kiểu dữ liệu data tương ứng qua json["data"]
  /// 1.  T.fromJson(response["data"]) nếu là model
  /// 2.  response["data"] nếu là data type
  factory BaseResponse.fromJson(Map<String, dynamic> json, T data) =>
      BaseResponse(
        status: json["status"],
        message: json["message"],
        data: data,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data,
      };
}
