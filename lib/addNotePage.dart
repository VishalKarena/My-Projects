import 'package:flutter/material.dart';
import 'package:practice/db_provider.dart';
import 'package:provider/provider.dart';

class addNotePage extends StatelessWidget {
  final bool isUpdate;
  String title;
  String desc;
  int sno;
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  // DBHelper? dbRef = DBHelper.getInstance;

  addNotePage({
    super.key,
    this.isUpdate = false,
    this.sno = 0,
    this.title = "",
    this.desc = "",
  });

  @override
  Widget build(BuildContext context) {
    if (isUpdate) {
      titleController.text = title;
      descController.text = desc;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isUpdate ? 'Update Note' : 'Add Note',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: 1200,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(color: Colors.grey[900]),
          child: Column(
            spacing: 15,
            children: [
              TextField(
                style: TextStyle(color: Colors.white),
                controller: titleController,
                decoration: InputDecoration(
                  label: Text("Title * "),
                  labelStyle: TextStyle(color: Colors.white54),
                  hintText: "Enter Your Title Here",
                  hintStyle: TextStyle(color: Colors.white70),
                  focusColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.amber),
                    borderRadius: BorderRadius.circular(11),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11),
                  ),
                ),
              ),
              TextField(
                style: TextStyle(color: Colors.white),
                controller: descController,
                maxLines: 4,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11),
                  ),
                  label: Text('Description * '),
                  hintStyle: TextStyle(color: Colors.white70),
                  labelStyle: TextStyle(color: Colors.white54),
                  fillColor: Colors.white,
                  hintText: "Enter Your Description Here...",
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11),
                    borderSide: BorderSide(color: Colors.amber),
                  ),
                ),
              ),
              Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.black,
                      ),
                      child: Text('Cancel'),
                    ),
                  ),

                  Expanded(
                    child: OutlinedButton(
                      onPressed: () async {
                        var title = titleController.text.trim();
                        var desc = descController.text.trim();

                        if (title.isNotEmpty && desc.isNotEmpty) {
                          if (isUpdate) {
                            context.read<DBProvider>().updateNote(
                              title,
                              desc,
                              sno,
                            );
                          } else {
                            context.read<DBProvider>().addNote(title, desc);
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Please fill All the Required Blanks!!',
                              ),
                              backgroundColor: Colors.redAccent,
                            ),
                          );
                        }
                        titleController.clear();
                        descController.clear();
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        foregroundColor: Colors.black,
                      ),
                      child: Text(isUpdate ? 'Update' : 'Add Note'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
