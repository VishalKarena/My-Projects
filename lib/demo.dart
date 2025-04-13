import 'package:flutter/material.dart';
import 'package:practice/newPage.dart';
import 'package:provider/provider.dart';
import 'ListMapProvider.dart';

class ListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ListMap Code", style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
      ),

      body: Consumer<ListMapProvider>(
        builder: (ctx, provider, __) {
          var data = provider.getData();
          return data.isNotEmpty
              ? Container(
                color: Colors.black,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(11),
                      ),
                      child: ListTile(
                        leading: Text(
                          (index + 1).toString(),
                          style: TextStyle(fontSize: 20, color: Colors.amber),
                        ),
                        title: Text(
                          '${data[index]["Title"]}',
                          style: TextStyle(color: Colors.yellow),
                        ),
                        subtitle: Text(
                          '${data[index]["Desc"]}',
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing: SizedBox(
                          width: 100,
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  context.read<ListMapProvider>().updateData({
                                    "Title": "Hii",
                                    "Desc": "Hey This is changed!!",
                                  }, index);
                                },
                                icon: Icon(
                                  Icons.edit_calendar,
                                  color: Colors.amber,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  context.read<ListMapProvider>().deleteData(
                                    index,
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
                    );
                  },
                  itemCount: data.length,
                ),
              )
              : Center(child: Text('No Data Yet!!'));
        },
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(15),
        ),
        child: FloatingActionButton(
          backgroundColor: Color.from(alpha: 100, red: 0, green: 0, blue: 0),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewPage()),
            );
          },
          child: Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}
