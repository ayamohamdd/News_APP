import 'package:flutter/material.dart';
import 'package:flutter_application_3/data/local/sqflite.dart';
import 'package:flutter_application_3/screens/home_screen.dart';
import 'package:flutter_application_3/screens/mynews_screen.dart';

class NewsDetails extends StatefulWidget {
  final bool isEditing;
  final String title;
  final String description;
  final int id;
  const NewsDetails(
      {super.key,
      required this.isEditing,
      required this.title,
      required this.description,
      required this.id});

  @override
  State<NewsDetails> createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  Sqflite sqlDb = Sqflite();

  final GlobalKey<FormState> _formKey = GlobalKey();

  TextEditingController description = TextEditingController();

  TextEditingController title = TextEditingController();

  var isEditing = false;

  int? id;

  @override
  void initState() {
    title.text = widget.title;
    description.text = widget.description;
    id = widget.id;
    isEditing = widget.isEditing;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(isEditing ? 'Edit News' : "Add News"),
          centerTitle: true,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: ListView(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Title Text
                    const Text(
                      "Title",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    // Title TextFormField
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1.0,
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: title,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "Title must not be null";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            hintText: "Title",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    // Note Text
                    const Text(
                      "Description",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    // Note TextFormField
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.0, color: Colors.grey),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.newline,
                          controller: description,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "Description must not be null";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            hintText: "Description",
                            border: InputBorder.none,
                            //contentPadding: EdgeInsets.symmetric(vertical: 80.0)
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),

                    const SizedBox(
                      height: 80.0,
                    ),
                    // Add Note || Edit Note Btn
                    Container(
                      width: 200.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        border:
                            Border.all(color: Colors.transparent, width: 1.0),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      child: MaterialButton(
                        onPressed: () async {
                          int response = isEditing
                              ? await sqlDb.updateData(
                                  'news',
                                  {
                                    'title': title.text,
                                    'description': description.text
                                  },
                                  'id = ${id}')
                              : await sqlDb.insertData('news', {
                                  "title": title.text,
                                  "description": description.text
                                });
                          if (response != 0) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyNewsScreen()),
                                (route) => false);
                          }
                          print(response);
                        },
                        child: Text(
                          isEditing ? "Edit News" : "Add News",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
