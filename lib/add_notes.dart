import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sqflite_test/home_page.dart';
import 'package:sqflite_test/sql_db.dart';

class AddNotesPage extends StatefulWidget {
  const AddNotesPage({Key? key}) : super(key: key);

  @override
  State<AddNotesPage> createState() => _AddNotesPageState();
}

class _AddNotesPageState extends State<AddNotesPage> {
  SqlDb sqlDb = SqlDb();
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController noteController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       backgroundColor: Colors.transparent,
      ),
      body: Container(
        padding: EdgeInsets.all(10.r),
        child: ListView(
          children: [
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(hintText: 'Title '),
                  ),
                  TextFormField(
                    controller: noteController,
                    decoration: InputDecoration(hintText: 'Note '),
                  ),
                  Container(
                    height: 20.h,
                  ),
                  MaterialButton(
                    onPressed: () async {
                      //Before using shortcut methods
                      // int response = await sqlDb.insertData(
                      //     'INSERT INTO notes ("note","title","color")'
                      //     'VALUES ("${noteController.text}" , "${titleController.text}","${colorController.text}")');
                      int response = await sqlDb.insert('notes', {
                        'note':noteController.text,
                        'title':titleController.text,
                      });
                      if (response > 0) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => HomePage()),
                            (route) => false);
                      }
                    },
                    child: Text('Add Note'),
                    color: Colors.blue,
                    textColor: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
