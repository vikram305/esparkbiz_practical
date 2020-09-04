import 'package:esparkbizpractical/data_models/saved_item_dm.dart';
import 'package:esparkbizpractical/modules/inventory/bloc/saved_item_bloc/saved_item_event.dart';
import 'package:esparkbizpractical/modules/inventory/bloc/saved_item_bloc/saved_item_state.dart';
import 'package:esparkbizpractical/repositories/inventory_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class SavedItemBloc extends Bloc<SavedItemEvent,SavedItemState>{

  InventoryRepository repository;
  SavedItemBloc({@required this.repository}) : super(FetchSavedItemInitial());


  @override
  Stream<SavedItemState> mapEventToState(SavedItemEvent event) async* {
    if(event is FetchSavedItems){
      yield FetchSavedItemsLoading();
      try{
        print('searching item for: ${event.roomId}');
        List<SavedItemDM> itemList=await repository.getAllSavedItems();
//        List<ItemDM> itemList=await repository.getAllItems();
        print('item list size in bloc: ${itemList.length}');
        yield FetchSavedItemsSuccess(items: itemList);
      }catch(e){
        yield FetchSavedItemError(message: "could not retrive data please try again");
      }

    }else if(event is AddItemToSavedItem){
      yield ItemAddeddSuccess(item: event.item);
    }
    else if(event is FetchItemsByFilter){
      if(event.querey.isEmpty){
        yield FetchItemsByFilterSuccess(items: event.items);
      }else{
        List<SavedItemDM> filteredRooms=await filterItemsBySearch(event.items, event.querey);
        yield FetchItemsByFilterSuccess(items: filteredRooms);
      }
    }else if(event is StoreAllSavedItemInDatabase){
      try{
        await repository.storeAllSavedItems(event.items);
        yield SavedItemStoredInDatabase();
      }catch(e){

      }
    }
  }

  Future<List<SavedItemDM>> filterItemsBySearch(List<SavedItemDM> items,String query) async{
    List<SavedItemDM> filteredItem=List();
    items.forEach((singleItem) {
      if(singleItem.fieldName.toLowerCase().contains(query.toLowerCase())){
        filteredItem.add(singleItem);
      }
    });
    return filteredItem;
  }

}