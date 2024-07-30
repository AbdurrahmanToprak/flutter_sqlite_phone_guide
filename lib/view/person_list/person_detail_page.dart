import 'package:flutter/material.dart';
import 'package:flutter_sqlite_phone_guide/view/model/person_model.dart';

class PersonDetailPage extends StatelessWidget {
  final PersonModel person;

  const PersonDetailPage({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(person.name ?? 'Detay'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'İsim: ${person.name ?? 'Belirtilmemiş'}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 10),
            Text(
              'Telefon: ${person.phone ?? 'Belirtilmemiş'}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
