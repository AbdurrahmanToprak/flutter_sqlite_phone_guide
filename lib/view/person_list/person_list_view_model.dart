import 'package:flutter/material.dart';
import 'package:flutter_sqlite_phone_guide/view/model/person_database_provider.dart';
import 'package:flutter_sqlite_phone_guide/view/model/person_model.dart';
import './person_list.dart';

abstract class PersonListViewModel extends State<PersonList> {
  late PersonDatabaseProvider personDatabaseProvider;

  PersonModel personModel = PersonModel();
  List<PersonModel> personList = [];
  Future getPersonList() async {
    personList = await personDatabaseProvider.getList();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    personDatabaseProvider = PersonDatabaseProvider();
    personDatabaseProvider.open();
  }

  Future<void> saveModel(StateSetter setState) async {
    if (personModel.name != null && personModel.phone != null) {
      final result = await personDatabaseProvider.insert(personModel);
      if (result) {
        setState(() {
          personList.add(personModel);
          personModel = PersonModel();
          getPersonList();
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Kaydedildi'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Kaydetme başarısız'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('İsim veya telefon boş olamaz'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
