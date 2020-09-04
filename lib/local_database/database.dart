import 'dart:async';

import 'package:esparkbizpractical/data_models/item_dm.dart';
import 'package:esparkbizpractical/data_models/room_dm.dart';
import 'package:esparkbizpractical/data_models/saved_item_dm.dart';
import 'package:esparkbizpractical/local_database/item_dao.dart';
import 'package:esparkbizpractical/local_database/room_dao.dart';
import 'package:esparkbizpractical/local_database/saved_item_dao.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [RoomDM,ItemDM,SavedItemDM])
abstract class AppDatabase extends FloorDatabase {
  RoomDao get roomDao;
  ItemDao get itemDao;
  SavedItemDao get savedItemDao;
}