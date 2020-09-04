import 'package:esparkbizpractical/data_models/saved_item_dm.dart';
import 'package:esparkbizpractical/modules/inventory/bloc/saved_item_bloc/saved_item_bloc.dart';
import 'package:esparkbizpractical/modules/inventory/bloc/saved_item_bloc/saved_item_event.dart';
import 'package:esparkbizpractical/modules/inventory/bloc/saved_item_bloc/saved_item_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SavedItemWidget extends StatefulWidget {
  final SavedItemBloc savedItemBloc;

  SavedItemWidget({@required this.savedItemBloc});

  @override
  _SavedItemWidgetState createState() => _SavedItemWidgetState();
}

class _SavedItemWidgetState extends State<SavedItemWidget> {

  SavedItemBloc get _savedItemBloc => widget.savedItemBloc;
  List<SavedItemDM> filteredSavedItemList = List();
  List<SavedItemDM> originalSavedItemList = List();
  Map<String,int> categoryMap=Map();

  @override
  void initState() {
    _savedItemBloc.add(FetchSavedItems());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: BlocBuilder<SavedItemBloc, SavedItemState>(
            cubit: _savedItemBloc,
            builder: (context, state) {
              print('state changed');
              if (state is FetchSavedItemInitial) {
                //do nothing
              }else if(state is SavedItemStoredInDatabase){
                Fluttertoast.showToast(
                    msg: "Items saved",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
              }
              else if (state is FetchSavedItemsLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is FetchSavedItemError) {
                if (originalSavedItemList.isNotEmpty) {
                  return _buildSavedItems();
                }
                return Center(child: Text('${state.message}'));
              }
              else if(state is FetchSavedItemError){
                if(originalSavedItemList.isNotEmpty){
                  return _buildSavedItems();
                }
                return Center(child: Text('${state.message}'));
              }
              else if (state is FetchSavedItemsSuccess) {
                originalSavedItemList = state.items;
                filteredSavedItemList = state.items;
                for (int i = 0; i < originalSavedItemList.length; i++) {
                  if(categoryMap.containsKey(originalSavedItemList[i].roomName)){
                    categoryMap['${originalSavedItemList[i].roomName}']=categoryMap[originalSavedItemList[i].roomName]+1;
                  }else{
                    categoryMap['${originalSavedItemList[i].roomName}']=1;
                  }
                }
              } else if (state is FetchItemsByFilterSuccess) {
                filteredSavedItemList = state.items;
              } else if (state is ItemAddeddSuccess) {
                print('ItemAddeddSuccess  block');
                bool isAlreadyAdded = false;
                for (int i = 0; i < originalSavedItemList.length; i++) {
                  if (originalSavedItemList[i].cid == state.item.cid &&
                      originalSavedItemList[i].roomId == state.item.roomId) {
                      state.item.quantity=originalSavedItemList[i].quantity+1;
                    originalSavedItemList[i].quantity =
                       state.item.quantity;
                    filteredSavedItemList[i].quantity=state.item.quantity;
                    isAlreadyAdded = true;
                    break;
                  }
                }
                if (!isAlreadyAdded) {
                  print('updating cart');
                  originalSavedItemList.add(state.item);
//                  if(categoryMap.containsKey(state.item.roomName)){
//                    categoryMap['${state.item.roomName}']=categoryMap[state.item]+1;
//                  }else{
//                    categoryMap['${state.item.roomName}']=1;
//                  }
                }
              }

              return _buildSavedItems();
            }
        ),
      ),
    );
  }

  _buildSavedItems() {
    return Column(
      children: <Widget>[

        Expanded(
          flex: 1,
//          child: _buildCategoryChips(categoryMap.keys.toList()),
          child: Container(),
        ),

        Expanded(
          flex: 4,
          child: Column(
            children: <Widget>[
              Divider(thickness: 3.0, height: 0, color: Colors.grey,),
              Container(
                color: Colors.grey.shade300,
                child: _buildTableHeaderWidget(),
              ),
              Divider(thickness: 3.0, height: 0, color: Colors.grey,),
              Expanded(
                child: _buildSavedItemList(),
              ),

              Divider(thickness: 1.0, height: 0, color: Colors.black,),
            ],
          ),
        ),

        RaisedButton(

          color: Colors.green,
          onPressed: () {
            _savedItemBloc.add(StoreAllSavedItemInDatabase(items: originalSavedItemList));
          },
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)
          ),
          child: Text(
            'Save', style: TextStyle(fontSize: 12.0, color: Colors.white),),
        )
      ],
    );
  }

  _buildCategoryChips(List<String> categories){
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: categoryMap.length,
      itemBuilder: (context,index){
        return Text(
          '${categories[index]} (${categoryMap[categories[index]]})', style: TextStyle(fontSize: 12.0, color: Colors.black),);
      },
    );
  }

  _buildTableHeaderWidget() {
    return Padding(
      padding: const EdgeInsets.only(
          left: 12.0, right: 4.0, top: 8.0, bottom: 8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text('Item', style: TextStyle(fontSize: 12.0),),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 8.0),
              child: Text('Qty'),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Text('Calculated (LBS)'),
            ),
          ),

          Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Container(
                width: 24.0,
              )
          ),
        ],
      ),
    );
  }


_buildSavedItemList() {
  return ListView.separated(
    shrinkWrap: true,
    separatorBuilder: (context, index) {
      return Divider(color: Colors.black, height: 0,);
    },
    itemCount: filteredSavedItemList.length,
    itemBuilder: (context, index) {
      return _buildSavedListItems(filteredSavedItemList[index]);
    },

  );
}

_buildSavedListItems(SavedItemDM item) {
  TextEditingController controller = TextEditingController(
      text: item.quantity.toString());
  return Padding(
    padding: const EdgeInsets.only(
        left: 12.0, right: 4.0, top: 8.0, bottom: 8.0),
    child: Row(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text('${item.fieldName}', style: TextStyle(fontSize: 12.0),),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Container(
              margin: EdgeInsets.only(
                  left: 8.0, right: 8.0, top: 0.0, bottom: 0.0),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(
                    color: Colors.black,
                    width: 0.5,
                  )
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: 12.0,),
                  controller: controller,
                  onChanged: (value) {
                    item.quantity = int.parse(value);
                    setState(() {
                      controller.clear();
                    });
                  },

                  decoration: InputDecoration(
                      border: InputBorder.none
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Text('${item.quantity * double.parse(item.density)}'),
          ),
        ),
        InkWell(
          onTap: (){
            originalSavedItemList.remove(item);
            filteredSavedItemList.remove(item);
            setState(() {

            });
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(Icons.delete_sweep, color: Colors.red,),
          ),
        ),
      ],
    ),
  );
}}
