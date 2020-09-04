import 'package:esparkbizpractical/data_models/room_dm.dart';
import 'package:floor/floor.dart';

@dao
abstract class RoomDao {

  @Query('SELECT * FROM rooms')
  Future<List<RoomDM>> getAllRooms();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertRoom(RoomDM rooms);

  @Query('SELECT * FROM rooms WHERE roomName = :query')
  Future<List<RoomDM>> findRoomBySearchQuery(String query);

  @Query('SELECT COUNT (*) FROM rooms')
  Future<void> getRoomCount();
}