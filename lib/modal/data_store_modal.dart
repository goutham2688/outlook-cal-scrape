import 'cal_event.dart';
import 'package:json_annotation/json_annotation.dart';

part 'data_store_modal.g.dart';

@JsonSerializable(explicitToJson: true)
class DataStoreModal {
  DateTime lastUpdatedTime;
  DateTime startDate;
  DateTime endDate;
  List<CalEvent> eventList;

  DataStoreModal({
    required this.lastUpdatedTime,
    required this.startDate,
    required this.endDate,
    required this.eventList,
  });

  static List<CalEvent> calDatafilterCalEventsByDate(
      {required DateTime date, required List<CalEvent> calData}) {
    return calData.where((calEvent) {
      return ((calEvent.startTime.day == date.day) &&
          (calEvent.startTime.month == date.month));
    }).toList();
  }

  factory DataStoreModal.fromJson(Map<String, dynamic> json) =>
      _$DataStoreModalFromJson(json);
  Map<String, dynamic> toJson() => _$DataStoreModalToJson(this);
}
