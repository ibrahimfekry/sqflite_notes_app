import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sqflite_test/home_page.dart';
import 'package:sqflite_test/sql_db.dart';

class EditNotesPage extends StatefulWidget {
  final note;
  final title;
  final id;

  EditNotesPage({Key? key, this.note, this.title, this.id}) : super(key: key);

  @override
  State<EditNotesPage> createState() => _EditNotesPageState();
}

class _EditNotesPageState extends State<EditNotesPage> {
  SqlDb sqlDb = SqlDb();
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController noteController = TextEditingController();
  TextEditingController titleController = TextEditingController();


  @override
  void initState() {
    noteController.text = widget.note;
    titleController.text = widget.title;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: noteController,
                    decoration: InputDecoration(hintText: 'Note '),
                  ),
                  TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(hintText: 'Title '),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  MaterialButton(
                    onPressed: () async {
                      // int response = await sqlDb.updateData(
                      //     'UPDATE notes SET note = "${noteController.text}",title = "${titleController.text}"'
                      //         'WHERE id = ${widget.id}'
                      // );
                      int response = await sqlDb.update('notes',{
                        'note':noteController.text,
                        'title':titleController.text,
                      }, 'id=${widget.id} ');
                      if (response > 0) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => HomePage()),
                                (route) => false);
                      }
                    },
                    child: Text('Edit Note'),
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
