import 'package:esparkbizpractical/data_models/item_dm.dart';
import 'package:esparkbizpractical/data_models/saved_item_dm.dart';
import 'package:esparkbizpractical/modules/inventory/bloc/item_bloc/item_bloc.dart';
import 'package:esparkbizpractical/modules/inventory/bloc/item_bloc/item_event.dart';
import 'package:esparkbizpractical/modules/inventory/bloc/item_bloc/item_state.dart';
import 'package:esparkbizpractical/modules/inventory/bloc/saved_item_bloc/saved_item_bloc.dart';
import 'package:esparkbizpractical/modules/inventory/bloc/saved_item_bloc/saved_item_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemWidget extends StatefulWidget {
  final ItemBloc itemBloc;
  final SavedItemBloc savedItemBloc;
  ItemWidget({@required this.itemBloc,@required this.savedItemBloc});
  @override
  _ItemWidgetState createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  ItemBloc get _itemBloc => widget.itemBloc;
  SavedItemBloc get _savedItemBloc => widget.savedItemBloc;
  List<ItemDM> originalItemList=List();
  List<ItemDM> filteredItemList=List();



  @override
  Widget build(BuildContext context) {
    return Container(
        child: _buidlItemWidget()
    );
  }

  Widget _buidlItemWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Items',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14.0),),
        ),
        Divider(thickness: 1.0,color: Colors.black,height: 0,),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: TextField(
            onChanged: (value){
              _itemBloc.add(FetchRoomItemsBySearch(items: originalItemList,querey: value));
            },
            style: TextStyle(fontSize:12.0),
            decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(fontSize: 12.0),
                icon: Icon(Icons.search,size: 20.0,),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none

            ),
          ),
        ),
        Divider(thickness: 1.0,color: Colors.black,height: 0,),
        Expanded(child: _buildItemList()),
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Divider(thickness: 1.0,color: Colors.black,height: 0,),
        ),
      ],
    );
  }

  Widget _buildItemList(){
    return BlocBuilder<ItemBloc,ItemState>(
      cubit: _itemBloc,
      builder: (context,state){
        if(state is FetchItemInitial){
          //do nothing
        }else if (state is FetchItemsLoading){
          if(originalItemList.isNotEmpty){
            return _buildItemListView();
          }
          return Center(child: CircularProgressIndicator());
        }else if(state is FetchItemError){
          if(originalItemList.isNotEmpty){
            return _buildItemListView();
          }
          return Center(child: Text('${state.message}'));
        }else if(state is FetchItemsSuccess){
          originalItemList=state.items;
          filteredItemList=state.items;
        }else if(state is FetchRoomItemsBySearchSuccess){
          filteredItemList=state.items;
        }

        return _buildItemListView();
      },
    );

  }

  Widget _buildItemListView(){
    return ListView.builder(
      shrinkWrap: true,
      itemCount: filteredItemList.length,
      itemBuilder: (context,index){
        return InkWell(
          onTap: (){
            _savedItemBloc.add(AddItemToSavedItem(item:SavedItemDM(
              cid: filteredItemList[index].cid,roomId: filteredItemList[index].roomId,
              roomName: filteredItemList[index].roomName,fieldName: filteredItemList[index].fieldName,
              density: filteredItemList[index].density,quantity: 1,lbs: 0.0
            )));
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0,top: 14.0,bottom: 14.0,right: 8.0),
            child: Text("${filteredItemList[index].fieldName}",
              style: TextStyle(fontSize: 12.0),
            ),
          ),
        );
      },
    );
  }

}
