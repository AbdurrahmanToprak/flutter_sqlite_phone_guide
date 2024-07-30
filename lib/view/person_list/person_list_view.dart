import 'package:flutter/material.dart';
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
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  )
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
                    child: Text("Kaydet"))
              ],
            ),
          ),
        );
      },
    );
  }
}
