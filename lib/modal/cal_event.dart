import 'package:json_annotation/json_annotation.dart';

part 'cal_event.g.dart';

@JsonSerializable()
class CalEvent {
  String title;
  DateTime startTime;
  DateTime endTime;

  CalEvent({
    required this.title,
    required this.startTime,
    required this.endTime,
  });

  factory CalEvent.fromJson(Map<String, dynamic> json) =>
      _$CalEventFromJson(json);
  Map<String, dynamic> toJson() => _$CalEventToJson(this);
}
