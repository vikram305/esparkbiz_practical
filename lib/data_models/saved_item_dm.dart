import 'package:floor/floor.dart';
import 'package:meta/meta.dart';


@Entity(
  tableName: 'saved_items',
  primaryKeys: ['cid','roomId']
)
class SavedItemDM{

  final String cid;

  final String roomId;

  final String roomName;

  final String fieldName;

   int quantity;

   String density;

  final double lbs;

  SavedItemDM({@required this.cid,@required this.roomId,@required this.roomName,@required this.fieldName,@required this.density,@required this.quantity,@required this.lbs});


//  factory ItemDM.fromJson(Map<String,dynamic> json) => _$ItemDMFromJson(json);
//
//  Map<String,dynamic> toJson()=> _$ItemDMToJson(this);
}