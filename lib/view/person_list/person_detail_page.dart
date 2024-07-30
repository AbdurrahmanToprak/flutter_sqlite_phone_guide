import 'package:flutter/material.dart';
import 'package:flutter_sqlite_phone_guide/view/model/person_model.dart';
import 'package:flutter_sqlite_phone_guide/view/model/person_database_provider.dart';

class PersonDetailPage extends StatelessWidget {
  final PersonModel person;

  const PersonDetailPage({super.key, required this.person});

  Future<void> _deletePerson(BuildContext context) async {
    if (person.id != null && person.id! > 0) {
      final personDatabaseProvider = PersonDatabaseProvider();

      await personDatabaseProvider.open();
      final success = await personDatabaseProvider.delete(person.id!);

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Kişi silindi'),
            duration: Duration(seconds: 2),
          ),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Silme başarısız'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Geçersiz ID'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kişi Detay'),
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
            const SizedBox(height: 10),
            Text(
              'Telefon: ${person.phone ?? 'Belirtilmemiş'}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    _deletePerson(context);
                  },
                  child: const Text("Kişiyi Sil"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
