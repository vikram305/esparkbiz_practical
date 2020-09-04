import 'package:esparkbizpractical/data_models/item_dm.dart';
import 'package:meta/meta.dart';

abstract class ItemEvent{

  @override
  List<Object> get props => [];
}


class FetchRoomItems extends ItemEvent{
  String roomId;
  FetchRoomItems({@required this.roomId});
}


class FetchRoomItemsBySearch extends ItemEvent{
  final List<ItemDM> items;
  final String querey;
  FetchRoomItemsBySearch({@required this.items,@required this.querey});
}