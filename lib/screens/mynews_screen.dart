import 'package:flutter/material.dart';
import 'package:flutter_application_3/data/local/sqflite.dart';
import 'package:flutter_application_3/screens/home_screen.dart';
import 'package:flutter_application_3/screens/news_details.dart';

class MyNewsScreen extends StatefulWidget {
  const MyNewsScreen({super.key});

  @override
  State<MyNewsScreen> createState() => _MyNewsScreenState();
}

class _MyNewsScreenState extends State<MyNewsScreen> {
  Sqflite sqlDb = Sqflite();
  Future<List<Map>> myReadData() async {
    List<Map> response = await sqlDb.readData('news');
    print(response);
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
                (route) => false);
          },
        ),
        title: Text('My News'),
      ),
      body: FutureBuilder(
          future: myReadData(),
          builder: (context, AsyncSnapshot<List<Map>> snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                // physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return buildNoteModel(snapshot.data![index]);
                },
                itemCount: snapshot.data!.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(
                  height: 5,
                ),
              );
            }
            return Center(
              child: const CircularProgressIndicator(
                color: Colors.orangeAccent,
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orangeAccent,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NewsDetails(
                      isEditing: false, title: '', description: '', id: 0)));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget buildNoteModel(Map news) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Dismissible(
        key: UniqueKey(),
        onDismissed: (direction) {
          int response = sqlDb.deleteData(
              'news',
              {'title': news["title"], 'description': news["description"]},
              'id = ${news["id"]}');

          print(response);
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              boxShadow: [const BoxShadow(color: Colors.orange, blurRadius: 5)],
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.orange, width: 0.3),
              color: Colors.white),
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 200,
                      child: Text(
                        '${news["title"]}',
                        style: const TextStyle(
                          fontSize: 14,
                          height: 1.5,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 3,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      width: 150,
                      child: Text(
                        news["description"],
                        style: const TextStyle(
                          fontSize: 10.0,
                        ),
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
              //  Edit
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NewsDetails(
                              isEditing: true,
                              title: news["title"],
                              description: news["description"],
                              id: news["id"])));
                },
                icon: const Icon(Icons.edit),
              )
            ],
          ),
        ),
      ),
    );
  }
}
