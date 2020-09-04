import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'item_dm.dart';

part 'room_dm.g.dart';

@Entity(tableName: 'rooms')
@JsonSerializable()
class RoomDM{

  @PrimaryKey(autoGenerate: false)
  @JsonKey(name: 'room_id')
  final String roomId;

  @JsonKey(name: 'room_name')
  final String roomName;

  @JsonKey(name: 'survey_id')
  final String surveyId;

  @ignore
  final List<ItemDM> items;

  RoomDM({@required this.roomId,@required this.roomName,@required this.surveyId,@required this.items});

  factory RoomDM.fromJson(Map<String,dynamic> json) => _$RoomDMFromJson(json);

  Map<String,dynamic> toJson()=> _$RoomDMToJson(this);

}