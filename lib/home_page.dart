import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sqflite_test/edit_notes.dart';
import 'package:sqflite_test/sql_db.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SqlDb sqlDb = SqlDb();
  bool isLoading = true;
  List notes = [];

  Future readData() async {
    List<Map> response = await sqlDb.read("notes");
    notes.addAll(response);
    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
            children: [
              SizedBox(height: 30.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [Text('My Notes',style: TextStyle(fontSize: 30),)],
              ),
              Expanded(
                child: ListView(
                  children: [
                    // MaterialButton(
                    //   onPressed: () async {
                    //     await sqlDb.deleteMyDatabase();
                    //   },
                    //   child: Text('Delete database'),
                    // ),
                    ListView.builder(
                        itemCount: notes.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              title: Text(
                                '${notes[index]['title']}',
                                style: TextStyle(
                                    fontSize: 22.sp, fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text('${notes[index]['note']}',maxLines: 6,),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                      onPressed: () async {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    EditNotesPage(
                                                      note: notes[index]['note'],
                                                      title: notes[index]
                                                          ['title'],
                                                      id: notes[index]['id'],
                                                    )));
                                      },
                                      icon: const Icon(Icons.edit)),
                                  IconButton(
                                      onPressed: () async {
                                        // int response = await sqlDb.deleteData(
                                        //     'DELETE FROM notes WHERE id = ${notes[index]['id']}');

                                        int response = await sqlDb.delete('notes',
                                            " id = ${notes[index]['id']}");
                                        if (response > 0) {
                                          notes.removeWhere((element) =>
                                              element['id'] ==
                                              notes[index]['id']);
                                          setState(() {});
                                        }
                                      },
                                      icon: const Icon(Icons.delete)),
                                ],
                              ),
                            ),
                          );
                        }),
                  ],
                ),
              ),
            ],
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('addNotes');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
