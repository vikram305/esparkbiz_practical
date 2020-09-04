// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_dm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomDM _$RoomDMFromJson(Map<String, dynamic> json) {
  return RoomDM(
    roomId: json['room_id'] as String,
    roomName: json['room_name'] as String,
    surveyId: json['survey_id'] as String,
    items: (json['items'] as List)
        ?.map((e) =>
            e == null ? null : ItemDM.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$RoomDMToJson(RoomDM instance) => <String, dynamic>{
      'room_id': instance.roomId,
      'room_name': instance.roomName,
      'survey_id': instance.surveyId,
      'items': instance.items,
    };
