import 'package:flutter/material.dart';
import 'package:my_todo_app/constant.dart';
import 'package:my_todo_app/controler/note_helper.dart';

import 'dis_screen.dart';
import 'form_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // بتشيك هل الداتا موجودة ولا لا
  @override
  void initState() {
    super.initState();
    Note().db.then((value) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primarycolor,
      appBar: AppBar(
        title: Center(
            child: Text(
          "ToDo",
          style: TextStyle(color: textcolor, fontSize: fontLarge),
        )),
        centerTitle: true,
        backgroundColor: primarydarkcolor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder(
          future: Note().getdb(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              return (snapshot.data.length == 0)
                  ? Center(
                      child: Text(
                        "Your ToDo list is Empty..",
                        style: TextStyle(fontSize: 30),
                      ),
                    )
                  : ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          color: Colors.transparent,
                          child: ListTile(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return FormScreen(
                                    id: "${snapshot.data[index].id}",
                                    description:
                                        "${snapshot.data[index].description}",
                                    title: "${snapshot.data[index].title}",
                                    date: "${snapshot.data[index].date}",
                                    done: "${snapshot.data[index].done}");
                              }));
                            },
                            title: Text(
                              "${snapshot.data[index].title}",
                              style: TextStyle(color: textcolor),
                            ),
                            subtitle: Text(
                              "${snapshot.data[index].date}",
                              style: TextStyle(color: textcolor),
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                Note().deletedb(snapshot.data[index].id).then((value) {
                                  setState(() {
                                    
                                  });
                                });
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: red,
                                size: 25,
                              ),
                            ),
                          ),
                        );
                      },
                    );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: primarycolor,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return DisScreen();
            }),
          );
        },
        child: const Icon(
          Icons.add,
          color: textcolor,
        ),
        backgroundColor: primarydarkcolor,
      ),
    );
  }
}
