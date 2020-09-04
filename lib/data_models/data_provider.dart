import 'package:esparkbizpractical/data_models/room_dm.dart';
import 'package:esparkbizpractical/network_util/api_base_helper.dart';
import 'package:esparkbizpractical/network_util/api_constants.dart';

class DataProvider{

  Future<List<RoomDM>> getData() async{
    List<RoomDM> roomList=new List<RoomDM>();
    ApiBaseHelper apiHelper=ApiBaseHelper();
    var response=await apiHelper.get(ApiConstants.BASE_URL+"${ApiConstants.MOVER}");
    print("response in provider: $response");
    var data=response['data'];
    print('data in provider: $data');
    List<dynamic> list=response['data']['itemslist'];
    for(int i=0;i<list.length;i++){
      roomList.add(RoomDM.fromJson(list[i]));
    }
    return roomList;
  }

}