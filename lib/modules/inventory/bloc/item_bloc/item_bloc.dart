import 'package:esparkbizpractical/data_models/item_dm.dart';
import 'package:esparkbizpractical/modules/inventory/bloc/item_bloc/item_event.dart';
import 'package:esparkbizpractical/modules/inventory/bloc/item_bloc/item_state.dart';
import 'package:esparkbizpractical/repositories/inventory_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class ItemBloc extends Bloc<ItemEvent,ItemState>{

  InventoryRepository repository;

  ItemBloc({@required this.repository}) : super(FetchItemInitial());


  @override
  Stream<ItemState> mapEventToState(ItemEvent event) async* {
    if(event is FetchRoomItems){
      yield FetchItemsLoading();
      try{
        List<ItemDM> itemList=await repository.getItemsByQuery(event.roomId);
//        List<ItemDM> itemList=await repository.getAllItems();
        yield FetchItemsSuccess(items: itemList);
      }catch(e){
        yield FetchItemError(message: "could not retrive data please try again");
      }

    }
    else if(event is FetchRoomItemsBySearch){
      if(event.querey.isEmpty){
        yield FetchRoomItemsBySearchSuccess(items: event.items);
      }else{
        List<ItemDM> filteredRooms=await filterItemsBySearch(event.items, event.querey);
        yield FetchRoomItemsBySearchSuccess(items: filteredRooms);
      }
    }
  }

  Future<List<ItemDM>> filterItemsBySearch(List<ItemDM> items,String query) async{
    List<ItemDM> filteredItem=List();
    items.forEach((singleItem) {
      if(singleItem.fieldName.toLowerCase().contains(query.toLowerCase())){
        filteredItem.add(singleItem);
      }
    });
    return filteredItem;
  }

}