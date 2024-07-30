import 'package:flutter/material.dart';
import 'package:flutter_sqlite_phone_guide/view/model/person_database_provider.dart';
import 'person_list_view.dart';

abstract class PersonListViewModel extends State<PersonList> {
  late PersonDatabaseProvider personDatabaseProvider;

  @override
  void initState() {
    super.initState();
    personDatabaseProvider = PersonDatabaseProvider();
    personDatabaseProvider.open();
  }
}

class PersonList extends StatefulWidget {
  const PersonList({super.key});

  @override
  PersonListView createState() => PersonListView();
}
