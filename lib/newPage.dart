import 'package:flutter/material.dart';
import 'package:practice/ListMapProvider.dart';
import 'package:provider/provider.dart';

class NewPage extends StatelessWidget {
  const NewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,

      body: Center(
        child: IconButton(
          icon: Icon(Icons.add, color: Colors.white),
          onPressed: () {
            context.read<ListMapProvider>().addData({
              "Title" : "Hello World",
              "Desc" : "Hello This is a beautiful note!!"
            });
          },
        ),
      ),
    );
  }
}
