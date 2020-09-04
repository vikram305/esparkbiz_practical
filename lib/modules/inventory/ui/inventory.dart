import 'package:esparkbizpractical/modules/inventory/bloc/item_bloc/item_bloc.dart';
import 'package:esparkbizpractical/modules/inventory/bloc/room_bloc/room_bloc.dart';
import 'package:esparkbizpractical/modules/inventory/bloc/saved_item_bloc/saved_item_bloc.dart';
import 'package:esparkbizpractical/modules/inventory/ui/item_widget.dart';
import 'package:esparkbizpractical/modules/inventory/ui/room_widget.dart';
import 'package:esparkbizpractical/modules/inventory/ui/saved_item_widget.dart';
import 'package:esparkbizpractical/repositories/inventory_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InventoryScreen extends StatefulWidget {
  final InventoryRepository repository;
  InventoryScreen({@required this.repository});

  @override
  _InventoryScreenState createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  InventoryRepository repository;
  RoomBloc roomBloc;
  ItemBloc itemBloc;
  SavedItemBloc savedItemBloc;

  @override
  void initState() {
    super.initState();
    savedItemBloc=SavedItemBloc(repository: widget.repository);
    roomBloc=RoomBloc(repository: widget.repository);
    itemBloc=ItemBloc(repository: widget.repository);


    print('init state of inventory');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text('Inventory'),
      ),
//      body: _buildBody(),
    body: _buildMainBody(),
    );
  }

  _buildMainBody(){
    return Column(
      children: <Widget>[
        Expanded(
            flex: 6,
            child: Container(
              child: _buildBody()
            )),
        Expanded(
            flex: 5,
            child: Container(
              color: Colors.greenAccent,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child:SavedItemWidget(savedItemBloc: savedItemBloc,)
                ),
              ),
            ))
      ],
    );
  }
  _buildBody() {
//    return RoomWidget(bloc: roomBloc,);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(child: RoomWidget(roomBloc: roomBloc,itemBloc: itemBloc,)),
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: VerticalDivider(color: Colors.black,thickness: 1.0,width: 0,),
        ),
        Expanded(child: ItemWidget(itemBloc: itemBloc,savedItemBloc: savedItemBloc,))
      ],
    );
  }

  @override
  void dispose() {
    roomBloc.close();
    itemBloc.close();
    savedItemBloc.close();
    super.dispose();
  }
}
