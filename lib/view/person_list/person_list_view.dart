import 'package:flutter/material.dart';
import 'package:flutter_sqlite_phone_guide/view/person_list/person_detail_page.dart';
import 'person_list_view_model.dart';
import '../model/person_model.dart';

class PersonListView extends PersonListViewModel {
  final TextEditingController _controller = TextEditingController();
  List<PersonModel> _filteredPersonList = [];

  @override
  void initState() {
    super.initState();
    _controller.addListener(_filterPersonList);
    getPersonList();
  }

  @override
  void dispose() {
    _controller.removeListener(_filterPersonList);
    _controller.dispose();
    super.dispose();
  }

  void _filterPersonList() {
    setState(() {
      _filteredPersonList = personList
          .where((person) => person.name!
              .toLowerCase()
              .contains(_controller.text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Telefon Rehberi",
          style: TextStyle(color: Colors.white),
        ),
        leading: const Icon(
          Icons.phone,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddPersonBottomSheet(context);
        },
        backgroundColor: Colors.green,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Ara',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: _filteredPersonList.isEmpty
                ? const Center(
                    child: Text("Kişi Yok"),
                  )
                : ListView.builder(
                    itemCount: _filteredPersonList.length,
                    itemBuilder: (context, index) => ListTile(
                      title: Text(_filteredPersonList[index].name.toString()),
                      subtitle:
                          Text(_filteredPersonList[index].phone.toString()),
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
                              person: _filteredPersonList[index],
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

  @override
  Future getPersonList() async {
    await super.getPersonList();
    _filterPersonList();
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
                Row(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          saveModel(setState);
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          "Kaydet",
                          style: TextStyle(color: Colors.green),
                        )),
                    const SizedBox(width: 8),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          "Geri Dön",
                          style: TextStyle(color: Colors.grey),
                        )),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
