// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cal_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CalEvent _$CalEventFromJson(Map<String, dynamic> json) => CalEvent(
      title: json['title'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
    );

Map<String, dynamic> _$CalEventToJson(CalEvent instance) => <String, dynamic>{
      'title': instance.title,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
    };
