import 'package:esparkbizpractical/data_models/data_provider.dart';
import 'package:esparkbizpractical/data_models/item_dm.dart';
import 'package:esparkbizpractical/data_models/room_dm.dart';
import 'package:esparkbizpractical/data_models/saved_item_dm.dart';
import 'package:esparkbizpractical/local_database/database.dart';
import 'package:flutter/cupertino.dart';

class InventoryRepository{

  final AppDatabase database;
  InventoryRepository({@required this.database});

  Future<List<RoomDM>> getAllDataFromServer() async{
    final DataProvider dataProvider = DataProvider();
    return await dataProvider.getData();
  }

  Future<List<RoomDM>> getAllRooms() async{
//    final database=await $FloorAppDatabase.databaseBuilder('inventory_database.db').build();
    return await database.roomDao.getAllRooms();
  }

  Future<List<RoomDM>> getRoomByQuery(String query) async{
//    final database=await $FloorAppDatabase.databaseBuilder('inventory_database.db').build();
    return await database.roomDao.findRoomBySearchQuery(query);
  }

  Future<List<ItemDM>> getAllItems() async{
//    final database=await $FloorAppDatabase.databaseBuilder('inventory_database.db').build();
    return await database.itemDao.getAllItems();
  }

  Future<List<ItemDM>> getItemsByQuery(String query) async{
//    final database=await $FloorAppDatabase.databaseBuilder('inventory_database.db').build();
    return await database.itemDao.findItemByRoomId(query);
  }

  Future<void> storeAllDataInDatabase(List<RoomDM> rooms) async{
    //to do: return error if data is not stored
//    final database=await $FloorAppDatabase.databaseBuilder('inventory_database.db').build();
  print('storeAllDataInDatabase actual list size: ${rooms.length}');
  int roomCount=0;
    rooms.forEach((room) async{
      int result=await database.roomDao.insertRoom(room);
      if(result>0){
        roomCount++;
        print('inserted in room: ${room.roomId} ${room.roomName}');
        print('roomCount: ${roomCount}');
        int itemCount=0;
        room.items.forEach((item) async{
          ItemDM itemDM=ItemDM(cid: item.cid,comments: item.comments,cubicFeet: item.cubicFeet,density: item.density,
            fieldName: item.fieldName,groupNameId: item.groupNameId,roomId: room.roomId,weight: item.weight,roomName: room.roomName
          );
          int res=await database.itemDao.insertItem(itemDM);
          if(res>0){
            itemCount++;
            print('inserted in items: ${itemDM.cid} ${itemDM.fieldName}');
            print('itemCount for ${room.roomId} : ${itemCount}');
          }

        });
      }
    });

  }

  Future<List<SavedItemDM>> getAllSavedItems() async{
//    final database=await $FloorAppDatabase.databaseBuilder('inventory_database.db').build();
    return await database.savedItemDao.getAllItems();
  }

  Future<void> storeAllSavedItems(List<SavedItemDM> itemsList) async{
//    final database=await $FloorAppDatabase.databaseBuilder('inventory_database.db').build();
      int count=0;
      await database.savedItemDao.removeAllItems();
      itemsList.forEach((item) async{
        int result=await database.savedItemDao.insertSavedItem(item);
        if(result>0){
          count++;
          print('inserted ${item.fieldName} count:${count}');
        }

      });
  }


}