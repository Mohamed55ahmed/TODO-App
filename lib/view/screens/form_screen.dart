import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../../constant.dart';

class FormScreen extends StatefulWidget {
  var id;
  var description;
  var title;
  var date;
  var done;


  @override
  _FormScreenState createState() => _FormScreenState();
  FormScreen({
    required this.id,
    required this.description,
    required this.title,
    required this.date,
    required this.done,
  });
}

class _FormScreenState extends State<FormScreen> {

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
          "Description",
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${widget.title}",
                style: TextStyle(
                  color: textcolor,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              Text("${widget.date}",
                style: TextStyle(
                  color: textcolor,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),),
              Text(
                  " ${widget.description}",
                style: TextStyle(
                  color: green,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Share.share("${widget.title} \n ${widget.date} \n   ${widget.description} ");
        },
        child: const Icon(
          Icons.share,
          color: textcolor,
        ),
        backgroundColor: primarydarkcolor,
      ),

    );
  }
}
