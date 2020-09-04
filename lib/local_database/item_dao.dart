import 'package:esparkbizpractical/data_models/item_dm.dart';
import 'package:floor/floor.dart';

@dao
abstract class ItemDao {

  @Query('SELECT * FROM items')
  Future<List<ItemDM>> getAllItems();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertItem(ItemDM items);

  @Query('SELECT * FROM items WHERE roomId = :roomId')
  Future<List<ItemDM>> findItemByRoomId(String roomId);

}
