import 'package:esparkbizpractical/data_models/saved_item_dm.dart';
import 'package:meta/meta.dart';

abstract class SavedItemEvent{

  @override
  List<Object> get props => [];
}


class FetchSavedItems extends SavedItemEvent{
  String roomId;
  FetchSavedItems({@required this.roomId});
}

class AddItemToSavedItem extends SavedItemEvent{
  final SavedItemDM item;
  AddItemToSavedItem({@required this.item});
}

class StoreAllSavedItemInDatabase extends SavedItemEvent{
  final List<SavedItemDM> items;
  StoreAllSavedItemInDatabase({@required this.items});
}



class FetchItemsByFilter extends SavedItemEvent{
  final List<SavedItemDM> items;
  final String querey;
  FetchItemsByFilter({@required this.items,@required this.querey});
}