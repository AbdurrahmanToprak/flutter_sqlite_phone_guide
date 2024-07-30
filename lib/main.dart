import 'package:flutter/material.dart';
import 'package:flutter_sqlite_phone_guide/view/person_list/person_list.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future main() async {
// Initialize FFI
  sqfliteFfiInit();

  databaseFactory = databaseFactoryFfi;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Telefon Rehberi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PersonList(),
    );
  }
}
