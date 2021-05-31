import 'dart:convert';

// có file Json lên https://app.quicktype.io/ là nó tạo ra cho
class NotifyModel {
  String sortType;
  String time;
  NotifyModel({
    this.sortType,
    this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'sortType': sortType,
      'time': time,
    };
  }

  factory NotifyModel.fromMap(Map<String, dynamic> map) {
    return NotifyModel(
      sortType: map['sortType'],
      time: map['time'],
    );
  }

  String toJson() => json.encode(toMap());

  factory NotifyModel.fromJson(String source) =>
      NotifyModel.fromMap(json.decode(source));

  @override
  String toString() => 'NotifyModel(sortType: $sortType, time: $time)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NotifyModel &&
        other.sortType == sortType &&
        other.time == time;
  }

  @override
  int get hashCode => sortType.hashCode ^ time.hashCode;
}
