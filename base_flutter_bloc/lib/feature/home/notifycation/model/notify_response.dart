// có file Json lên https://app.quicktype.io/ là nó tạo ra cho
class NotifyResponse {
  NotifyResponse(
      {this.id, this.title, this.content, this.time, this.isRead = false});

  int id;
  String title;
  String content;
  String time;
  bool isRead;
//xem có cần thì thêm 2 cái bên dưới vào, ko thì thừa thãi
// sử dung khi response trả về để convert cho đúng trường
  factory NotifyResponse.fromJson(Map<String, dynamic> json) => NotifyResponse(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        time: json["time"],
        isRead: json["isRead"],
      );
// dùng để tạo gửi lên
  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "time": time,
        "isRead": isRead,
      };
}
