import 'package:esparkbizpractical/data_models/saved_item_dm.dart';
import 'package:floor/floor.dart';

@dao
abstract class SavedItemDao {

  @Query('SELECT * FROM saved_items')
  Future<List<SavedItemDM>> getAllItems();

  @Query('DELETE FROM saved_items')
  Future<void> removeAllItems();


  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertSavedItem(SavedItemDM items);

}
