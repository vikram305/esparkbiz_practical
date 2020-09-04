import 'package:bloc/bloc.dart';
import 'package:esparkbizpractical/modules/inventory/ui/inventory.dart';
import 'package:esparkbizpractical/repositories/inventory_repository.dart';
import 'package:esparkbizpractical/simple_bloc_delegate.dart';
import 'package:flutter/material.dart';

import 'local_database/database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer=SimpleBlocDelegate();
  final database=await $FloorAppDatabase.databaseBuilder('inventory_database.db').build();
  final repository=InventoryRepository(database:database);
  runApp(MyApp(repository: repository,));
}

class MyApp extends StatelessWidget {
  final InventoryRepository repository;
  MyApp({@required this.repository});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
//      home: InventoryScreen(),
      home: InventoryScreen(repository:repository),
    );
  }
}

