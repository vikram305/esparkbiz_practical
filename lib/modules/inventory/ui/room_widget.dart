import 'package:esparkbizpractical/data_models/room_dm.dart';
import 'package:esparkbizpractical/modules/inventory/bloc/item_bloc/item_bloc.dart';
import 'package:esparkbizpractical/modules/inventory/bloc/item_bloc/item_event.dart';
import 'package:esparkbizpractical/modules/inventory/bloc/room_bloc/room_bloc.dart';
import 'package:esparkbizpractical/modules/inventory/bloc/room_bloc/room_event.dart';
import 'package:esparkbizpractical/modules/inventory/bloc/room_bloc/room_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoomWidget extends StatefulWidget {
  final RoomBloc roomBloc;
  final ItemBloc itemBloc;
  RoomWidget({@required this.roomBloc,@required this.itemBloc});

  @override
  _RoomWidgetState createState() => _RoomWidgetState();
}

class _RoomWidgetState extends State<RoomWidget> {
  RoomBloc get _roomBloc => widget.roomBloc;
  ItemBloc get _itemBloc => widget.itemBloc;
  List<RoomDM> originalRoomList=List();
  List<RoomDM> filteredRoomList=List();

  @override
  void initState() {
    _roomBloc.add(FetchRooms());
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildRoomWidget()

      );
  }

  Widget _buildRoomWidget() {
   return Column(
     mainAxisAlignment: MainAxisAlignment.start,
     crossAxisAlignment: CrossAxisAlignment.start,
     children: <Widget>[
       Padding(
         padding: const EdgeInsets.all(8.0),
         child: Text('Rooms',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14.0),),
       ),
       Divider(thickness: 1.0,color: Colors.black,height: 0,),
       Padding(
         padding: const EdgeInsets.only(left: 8.0),
         child: TextField(
           onChanged: (value){
             _roomBloc.add(FetchRoomBySearch(rooms: originalRoomList,querey: value));
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
       Expanded(child: _buildRoomList()),
       Padding(
         padding: const EdgeInsets.only(bottom: 12.0),
         child: Divider(thickness: 1.0,color: Colors.black,height: 0,),
       ),
     ],
   );
  }

  Widget _buildRoomList(){
    return BlocBuilder<RoomBloc,RoomState>(
      cubit: _roomBloc,
      builder: (context,state){
        if(state is FetchRoomsInitial){
          //do nothing
        }else if (state is FetchRoomsLoading){
          return Center(child: CircularProgressIndicator());
        }else if(state is FetchRoomsError){
          if(originalRoomList.isNotEmpty){
            return _buildRoomListView();
          }
          return Center(child: Text('${state.message}'));
        }else if(state is FetchRoomsSuccess){
          originalRoomList=state.rooms;
          filteredRoomList=state.rooms;
          if(filteredRoomList.isNotEmpty){
            _itemBloc.add(FetchRoomItems(roomId: filteredRoomList[0].roomId));
          }

        }else if(state is FetchRoomsBySearchSuccess){
          filteredRoomList=state.rooms;
          if(filteredRoomList.isNotEmpty){
            _itemBloc.add(FetchRoomItems(roomId: filteredRoomList[0].roomId));
          }
        }

        return _buildRoomListView();
      },
    );
  }

  Widget _buildRoomListView(){
    return ListView.builder(
      shrinkWrap: true,
      itemCount: filteredRoomList.length,
      itemBuilder: (context,index){
        return InkWell(
          onTap: (){
            _itemBloc.add(FetchRoomItems(roomId: filteredRoomList[index].roomId));
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0,top: 14.0,bottom: 14.0,right: 8.0),
            child: Text("${filteredRoomList[index].roomName}",
              style: TextStyle(fontSize: 12.0),
            ),
          ),
        );
      },
    );
  }
}
