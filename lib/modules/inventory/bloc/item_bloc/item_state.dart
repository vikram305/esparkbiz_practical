import 'package:esparkbizpractical/data_models/item_dm.dart';
import 'package:meta/meta.dart';

abstract class ItemState{

  @override
  List<Object> get props => [];
}

class FetchItemInitial extends ItemState{}
class FetchItemsLoading extends ItemState{}
class FetchItemsSuccess extends ItemState{
  final List<ItemDM> items;
  FetchItemsSuccess({@required this.items});
}

class FetchRoomItemsBySearchSuccess extends ItemState{
  final List<ItemDM> items;
  FetchRoomItemsBySearchSuccess({@required this.items});
}

class FetchItemError extends ItemState{
  final String message;
  FetchItemError({@required this.message});
}