import 'package:esparkbizpractical/data_models/saved_item_dm.dart';
import 'package:meta/meta.dart';

abstract class SavedItemState{

  @override
  List<Object> get props => [];
}

class FetchSavedItemInitial extends SavedItemState{}
class FetchSavedItemsLoading extends SavedItemState{}
class FetchSavedItemsSuccess extends SavedItemState{
  final List<SavedItemDM> items;
  FetchSavedItemsSuccess({@required this.items});
}

class ItemAddeddSuccess extends SavedItemState{
  final SavedItemDM item;
  ItemAddeddSuccess({@required this.item});
}

class SavedItemStoredInDatabase extends SavedItemState{

}

class FetchItemsByFilterSuccess extends SavedItemState{
  final List<SavedItemDM> items;
  FetchItemsByFilterSuccess({@required this.items});
}

class FetchSavedItemError extends SavedItemState{
  final String message;
  FetchSavedItemError({@required this.message});
}