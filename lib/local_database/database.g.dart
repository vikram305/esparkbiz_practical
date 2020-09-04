// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  RoomDao _roomDaoInstance;

  ItemDao _itemDaoInstance;

  SavedItemDao _savedItemDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `rooms` (`roomId` TEXT, `roomName` TEXT, `surveyId` TEXT, PRIMARY KEY (`roomId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `items` (`cid` TEXT, `roomId` TEXT, `roomName` TEXT, `fieldName` TEXT, `comments` TEXT, `cubicFeet` TEXT, `weight` TEXT, `groupNameId` TEXT, `density` TEXT, FOREIGN KEY (`roomId`) REFERENCES `rooms` (`roomId`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`cid`, `roomId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `saved_items` (`cid` TEXT, `roomId` TEXT, `roomName` TEXT, `fieldName` TEXT, `quantity` INTEGER, `density` TEXT, `lbs` REAL, PRIMARY KEY (`cid`, `roomId`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  RoomDao get roomDao {
    return _roomDaoInstance ??= _$RoomDao(database, changeListener);
  }

  @override
  ItemDao get itemDao {
    return _itemDaoInstance ??= _$ItemDao(database, changeListener);
  }

  @override
  SavedItemDao get savedItemDao {
    return _savedItemDaoInstance ??= _$SavedItemDao(database, changeListener);
  }
}

class _$RoomDao extends RoomDao {
  _$RoomDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _roomDMInsertionAdapter = InsertionAdapter(
            database,
            'rooms',
            (RoomDM item) => <String, dynamic>{
                  'roomId': item.roomId,
                  'roomName': item.roomName,
                  'surveyId': item.surveyId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _roomsMapper = (Map<String, dynamic> row) => RoomDM(
      roomId: row['roomId'] as String,
      roomName: row['roomName'] as String,
      surveyId: row['surveyId'] as String);

  final InsertionAdapter<RoomDM> _roomDMInsertionAdapter;

  @override
  Future<List<RoomDM>> getAllRooms() async {
    return _queryAdapter.queryList('SELECT * FROM rooms', mapper: _roomsMapper);
  }

  @override
  Future<List<RoomDM>> findRoomBySearchQuery(String query) async {
    return _queryAdapter.queryList('SELECT * FROM rooms WHERE roomName = ?',
        arguments: <dynamic>[query], mapper: _roomsMapper);
  }

  @override
  Future<void> getRoomCount() async {
    await _queryAdapter.queryNoReturn('SELECT COUNT (*) FROM rooms');
  }

  @override
  Future<int> insertRoom(RoomDM rooms) {
    return _roomDMInsertionAdapter.insertAndReturnId(
        rooms, OnConflictStrategy.replace);
  }
}

class _$ItemDao extends ItemDao {
  _$ItemDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _itemDMInsertionAdapter = InsertionAdapter(
            database,
            'items',
            (ItemDM item) => <String, dynamic>{
                  'cid': item.cid,
                  'roomId': item.roomId,
                  'roomName': item.roomName,
                  'fieldName': item.fieldName,
                  'comments': item.comments,
                  'cubicFeet': item.cubicFeet,
                  'weight': item.weight,
                  'groupNameId': item.groupNameId,
                  'density': item.density
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _itemsMapper = (Map<String, dynamic> row) => ItemDM(
      cid: row['cid'] as String,
      roomId: row['roomId'] as String,
      roomName: row['roomName'] as String,
      fieldName: row['fieldName'] as String,
      comments: row['comments'] as String,
      cubicFeet: row['cubicFeet'] as String,
      weight: row['weight'] as String,
      groupNameId: row['groupNameId'] as String,
      density: row['density'] as String);

  final InsertionAdapter<ItemDM> _itemDMInsertionAdapter;

  @override
  Future<List<ItemDM>> getAllItems() async {
    return _queryAdapter.queryList('SELECT * FROM items', mapper: _itemsMapper);
  }

  @override
  Future<List<ItemDM>> findItemByRoomId(String roomId) async {
    return _queryAdapter.queryList('SELECT * FROM items WHERE roomId = ?',
        arguments: <dynamic>[roomId], mapper: _itemsMapper);
  }

  @override
  Future<int> insertItem(ItemDM items) {
    return _itemDMInsertionAdapter.insertAndReturnId(
        items, OnConflictStrategy.replace);
  }
}

class _$SavedItemDao extends SavedItemDao {
  _$SavedItemDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _savedItemDMInsertionAdapter = InsertionAdapter(
            database,
            'saved_items',
            (SavedItemDM item) => <String, dynamic>{
                  'cid': item.cid,
                  'roomId': item.roomId,
                  'roomName': item.roomName,
                  'fieldName': item.fieldName,
                  'quantity': item.quantity,
                  'density': item.density,
                  'lbs': item.lbs
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _saved_itemsMapper = (Map<String, dynamic> row) => SavedItemDM(
      cid: row['cid'] as String,
      roomId: row['roomId'] as String,
      roomName: row['roomName'] as String,
      fieldName: row['fieldName'] as String,
      density: row['density'] as String,
      quantity: row['quantity'] as int,
      lbs: row['lbs'] as double);

  final InsertionAdapter<SavedItemDM> _savedItemDMInsertionAdapter;

  @override
  Future<List<SavedItemDM>> getAllItems() async {
    return _queryAdapter.queryList('SELECT * FROM saved_items',
        mapper: _saved_itemsMapper);
  }

  @override
  Future<void> removeAllItems() async {
    await _queryAdapter.queryNoReturn('DELETE FROM saved_items');
  }

  @override
  Future<int> insertSavedItem(SavedItemDM items) {
    return _savedItemDMInsertionAdapter.insertAndReturnId(
        items, OnConflictStrategy.replace);
  }
}
