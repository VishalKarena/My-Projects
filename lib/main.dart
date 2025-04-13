import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:practice/addNotePage.dart';
import 'package:practice/db_helper.dart';
import 'package:practice/db_provider.dart';
import 'package:provider/provider.dart';
import 'setting_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => DBProvider(dbHelper: DBHelper.getInstance),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  bool? get isDarkMode => null;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Notes App',
      theme: isDarkMode ?? ThemeData.dark() : ThemeData.light(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    context.read<DBProvider>().getInitialNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          PopupMenuButton(
            icon: Icon(FontAwesomeIcons.ellipsis),
            itemBuilder: (_) {
              return [
                PopupMenuItem(
                  child: Row(
                    children: [
                      InkWell(
                        onTap:
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SettingPage(),
                              ),
                            ),
                        child: Icon(FontAwesomeIcons.gear),
                      ),
                      SizedBox(width: 11),
                      InkWell(
                        onTap:
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SettingPage(),
                              ),
                            ),
                        child: Text('Settings'),
                      ),
                    ],
                  ),
                ),
              ];
            },
          ),
        ],
        actionsPadding: EdgeInsets.only(right: 10),
      ),

      body: Container(
        color: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Notes',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: Consumer<DBProvider>(
                builder: (ctx, provider, __) {
                  List<Map<String, dynamic>> allNotes = provider.getNotes();

                  return allNotes.isNotEmpty
                      ? ListView.builder(
                        itemBuilder: (_, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(11),
                              ),
                              padding: EdgeInsets.only(top: 5),
                              child: ListTile(
                                leading: Text(
                                  style: TextStyle(
                                    color: Colors.amber,
                                    fontSize: 20,
                                  ),
                                  (index + 1).toString(),
                                ),
                                title: Text(
                                  style: TextStyle(color: Colors.white),
                                  allNotes[index][DBHelper.TABLE_NOTE_TITLE]
                                      .toString(),
                                ),
                                subtitle: Text(
                                  style: TextStyle(color: Colors.white),
                                  allNotes[index][DBHelper.TABLE_NOTE_DESC]
                                      .toString(),
                                ),
                                trailing: SizedBox(
                                  width: 96,
                                  child: Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          Icons.edit_calendar,
                                          color: Colors.amber,
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder:
                                                  (context) => addNotePage(
                                                    isUpdate: true,
                                                    title:
                                                        allNotes[index][DBHelper
                                                            .TABLE_NOTE_TITLE],
                                                    desc:
                                                        allNotes[index][DBHelper
                                                            .TABLE_NOTE_DESC],
                                                    sno:
                                                        allNotes[index][DBHelper
                                                            .TABLE_NOTE_SNO],
                                                  ),
                                            ),
                                          );
                                        },
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          context.read<DBProvider>().deleteNote(
                                            allNotes[index][DBHelper
                                                .TABLE_NOTE_SNO],
                                          );
                                        },
                                        icon: Icon(
                                          Icons.delete_forever,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: allNotes.length,
                      )
                      : Center(
                        child: Text(
                          'No notes yet',
                          style: TextStyle(color: Colors.white70),
                        ),
                      );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    onPressed: () async {
                      //note to be added from here
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => addNotePage()),
                      );
                    },
                    backgroundColor: Colors.amber,
                    child: Icon(Icons.add, color: Colors.black),
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
