import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sqlite_phone_guide/view/person_list/person_detail_page.dart';
import 'person_list_view_model.dart';

class PersonListView extends PersonListViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rehber"),
        leading: const Icon(Icons.phone),
        backgroundColor: Colors.blue,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddPersonBottomSheet(context);
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Expanded(
            child: personList.isEmpty
                ? const Center(
                    child: Text(
                    "Kişi Yok",
                  ))
                : ListView.builder(
                    itemCount: personList.length,
                    itemBuilder: (context, index) => ListTile(
                      title: Text(personList[index].name.toString()),
                      subtitle: Text(personList[index].phone.toString()),
                      leading: const Icon(Icons.account_box),
                      trailing: const Icon(
                        Icons.phone,
                        color: Colors.green,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PersonDetailPage(
                              person: personList[index],
                            ),
                          ),
                        ).then((_) {
                          getPersonList();
                        });
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  void showAddPersonBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Card(
          elevation: 20,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Wrap(
              runSpacing: 10,
              children: [
                TextField(
                  onChanged: (value) => personModel.name = value,
                  decoration: const InputDecoration(
                      hintText: "Name", border: OutlineInputBorder()),
                ),
                TextField(
                    onChanged: (value) => personModel.phone = value,
                    decoration: const InputDecoration(
                        hintText: "Phone", border: OutlineInputBorder())),
                ElevatedButton(
                    onPressed: () {
                      saveModel(setState);
                      Navigator.of(context).pop();
                    },
                    child: const Text("Kaydet")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Geri Dön")),
              ],
            ),
          ),
        );
      },
    );
  }
}
