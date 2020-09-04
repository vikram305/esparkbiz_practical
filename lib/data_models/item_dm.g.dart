// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_dm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemDM _$ItemDMFromJson(Map<String, dynamic> json) {
  return ItemDM(
    cid: json['c_id'] as String,
    fieldName: json['c_field_name'] as String,
    comments: json['c_comments'] as String,
    cubicFeet: json['c_cubic_feet'] as String,
    weight: json['c_weight'] as String,
    groupNameId: json['group_name_id'] as String,
    density: json['density'] as String,
  );
}

Map<String, dynamic> _$ItemDMToJson(ItemDM instance) => <String, dynamic>{
      'c_id': instance.cid,
      'c_field_name': instance.fieldName,
      'c_comments': instance.comments,
      'c_cubic_feet': instance.cubicFeet,
      'c_weight': instance.weight,
      'group_name_id': instance.groupNameId,
      'density': instance.density,
    };
