import 'package:esparkbizpractical/data_models/room_dm.dart';
import 'package:meta/meta.dart';

abstract class RoomState{

  @override
  List<Object> get props => [];
}

class FetchRoomsInitial extends RoomState{}
class FetchRoomsLoading extends RoomState{}
class FetchRoomsSuccess extends RoomState{
  final List<RoomDM> rooms;
  FetchRoomsSuccess({@required this.rooms});
}

class FetchRoomsBySearchSuccess extends RoomState{
  final List<RoomDM> rooms;
  FetchRoomsBySearchSuccess({@required this.rooms});
}

class FetchRoomsError extends RoomState{
  final String message;
  FetchRoomsError({@required this.message});
}