import 'package:esparkbizpractical/data_models/room_dm.dart';
import 'package:esparkbizpractical/modules/inventory/bloc/room_bloc/room_event.dart';
import 'package:esparkbizpractical/modules/inventory/bloc/room_bloc/room_state.dart';
import 'package:esparkbizpractical/network_util/app_exception.dart';
import 'package:esparkbizpractical/repositories/inventory_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class RoomBloc extends Bloc<RoomEvent,RoomState>{

  InventoryRepository repository;
  RoomBloc({@required this.repository}) : super(FetchRoomsInitial());


  @override
  Stream<RoomState> mapEventToState(RoomEvent event) async* {
    if(event is FetchRooms){
      yield FetchRoomsLoading();
      List<RoomDM> roomList=await repository.getAllRooms();
      print("after getting data from local database: ${roomList.length}");
      if(roomList.length>0){
        yield FetchRoomsSuccess(rooms: roomList);
      }
      try{
        List<RoomDM> roomDataFromServer=await repository.getAllDataFromServer();
        await repository.storeAllDataInDatabase(roomDataFromServer);
        roomList=await repository.getAllRooms();
        yield FetchRoomsSuccess(rooms: roomList);
      }catch(e){
        if(e is AppException){
          yield FetchRoomsError(message: e.message);
        }else{
          //throw database exception
        }
      }

    }
    else if(event is FetchRoomBySearch){
      if(event.querey.isEmpty){
        yield FetchRoomsBySearchSuccess(rooms: event.rooms);
      }else{
        List<RoomDM> filteredRooms=await filterRoomBySearch(event.rooms, event.querey);
        yield FetchRoomsBySearchSuccess(rooms: filteredRooms);
      }
    }
  }

  Future<List<RoomDM>> filterRoomBySearch(List<RoomDM> rooms,String query) async{
    List<RoomDM> filteredRoom=List();
    rooms.forEach((singleRoom) {
      if(singleRoom.roomName.toLowerCase().contains(query.toLowerCase())){
        filteredRoom.add(singleRoom);
      }
    });
    return filteredRoom;
  }

}