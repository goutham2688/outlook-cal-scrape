// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_store_modal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataStoreModal _$DataStoreModalFromJson(Map<String, dynamic> json) =>
    DataStoreModal(
      lastUpdatedTime: DateTime.parse(json['lastUpdatedTime'] as String),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      eventList: (json['eventList'] as List<dynamic>)
          .map((e) => CalEvent.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataStoreModalToJson(DataStoreModal instance) =>
    <String, dynamic>{
      'lastUpdatedTime': instance.lastUpdatedTime.toIso8601String(),
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'eventList': instance.eventList.map((e) => e.toJson()).toList(),
    };
