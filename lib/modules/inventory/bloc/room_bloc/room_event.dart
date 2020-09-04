import 'package:esparkbizpractical/data_models/room_dm.dart';
import 'package:meta/meta.dart';

abstract class RoomEvent{

  @override
  List<Object> get props => [];
}

class FetchRooms extends RoomEvent{

}

class FetchRoomBySearch extends RoomEvent{
  final List<RoomDM> rooms;
  final String querey;
  FetchRoomBySearch({@required this.rooms,@required this.querey});
}