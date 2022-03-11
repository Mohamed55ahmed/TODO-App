import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:my_todo_app/controler/note_helper.dart';
import 'package:my_todo_app/view/screens/home_screen.dart';
import '../../constant.dart';

class DisScreen extends StatefulWidget {
  @override
  _DisScreenState createState() => _DisScreenState();
}

class _DisScreenState extends State<DisScreen> {
  String? title, description;
  String dateTime = "Date";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primarycolor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: textcolor,
            size: 27,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Center(
            child: Text(
          "ADD",
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
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            //title
            TextFormField(
              decoration: InputDecoration(
                labelText: "Title",
                labelStyle: TextStyle(color: green),
                hintText: "Enter Title",
                fillColor: primarydarkcolor,
                helperStyle: TextStyle(color: green),
                contentPadding: EdgeInsets.all(5),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(DPadding)),
                    borderSide:
                        BorderSide(color: primarydarkcolor, width: 0.5)),
                disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(DPadding)),
                    borderSide:
                        BorderSide(color: primarydarkcolor, width: 0.5)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(DPadding)),
                    borderSide:
                        BorderSide(color: primarydarkcolor, width: 0.5)),
              ),
              onChanged: (val) {
                setState(() {
                  title = val;
                });
              },
            ),
            SizedBox(
              height: 15,
            ),
            Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Date",
                  style: TextStyle(color: textcolor),
                )),
            SizedBox(
              height: 5,
            ),
            //dateTime
            GestureDetector(
              onTap: () {
                DatePicker.showDatePicker(
                  context,
                  currentTime: DateTime.now(),
                  locale: LocaleType.en,
                  maxTime: DateTime(2030, 1, 1),
                  minTime: DateTime(DateTime.now().year, DateTime.now().month,
                      DateTime.now().day),
                  onChanged: (date) {
                    setState(() {
                      dateTime = "${date.year}-${date.month}-${date.day}";
                    });
                  },
                  onConfirm: (date) {
                    setState(() {
                      dateTime = "${date.year}-${date.month}-${date.day}";
                    });
                  },
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    ),
                    border: Border.all(color: primarydarkcolor, width: 0.5),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 20, horizontal: 6),
                    child: Text(
                      "$dateTime",
                      style: TextStyle(
                        color: textcolor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            //description
            TextFormField(
              maxLines: 8,
              decoration: InputDecoration(
                labelText: "description",
                labelStyle: TextStyle(color: green),
                hintText: "Enter description",
                fillColor: primarydarkcolor,
                helperStyle: TextStyle(color: green),
                contentPadding: EdgeInsets.all(5),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(DPadding)),
                    borderSide:
                        BorderSide(color: primarydarkcolor, width: 0.5)),
                disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(DPadding)),
                    borderSide:
                        BorderSide(color: primarydarkcolor, width: 0.5)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(DPadding)),
                    borderSide:
                        BorderSide(color: primarydarkcolor, width: 0.5)),
              ),
              onChanged: (val) {
                setState(() {
                  description = val;
                });
              },
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(primary: primarydarkcolor),
              onPressed: () {
                Note().insertdb({
                  "description": description,
                  "title": title,
                  "date": dateTime,
                  "done": "0"
                }).then((value) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                      (route) => false);
                });
              },
              icon: Icon(
                Icons.add,
                size: 18,
                color: textcolor,
              ),
              label: Text(
                "ADD",
                style: TextStyle(color: textcolor),
              ),
            )
          ],
        ),
      )),
    );
  }
}
