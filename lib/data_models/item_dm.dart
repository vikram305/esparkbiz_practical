import 'package:esparkbizpractical/data_models/room_dm.dart';
import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'item_dm.g.dart';

@Entity(tableName: 'items',
  primaryKeys: ['cid','roomId'],
  foreignKeys: [
    ForeignKey(
      childColumns: ['roomId'],
      parentColumns: ['roomId'],
      entity: RoomDM
    )
  ]
)
@JsonSerializable()
class ItemDM{

  @JsonKey(name: 'c_id')
  final String cid;

  @JsonKey(ignore: true)
  final String roomId;

  @JsonKey(ignore: true)
  final String roomName;

  @JsonKey(name: 'c_field_name')
  final String fieldName;

  @JsonKey(name: 'c_comments')
  final String comments;

  @ColumnInfo(nullable: true)
  @JsonKey(name: 'c_cubic_feet')
  final String cubicFeet;

  @JsonKey(name: 'c_weight')
  final String weight;

  @JsonKey(name: 'group_name_id')
  final String groupNameId;

  @JsonKey(name: 'density')
  final String density;

  ItemDM({@required this.cid,@required this.roomId,@required this.roomName,@required this.fieldName,@required this.comments, @required this.cubicFeet, @required this.weight, @required this.groupNameId,@required this.density});


  factory ItemDM.fromJson(Map<String,dynamic> json) => _$ItemDMFromJson(json);

  Map<String,dynamic> toJson()=> _$ItemDMToJson(this);
}