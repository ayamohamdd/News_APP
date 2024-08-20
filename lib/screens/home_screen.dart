import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/data/remote/dio_helper.dart';
import 'package:flutter_application_3/models/article_model.dart';
import 'package:flutter_application_3/screens/mynews_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Article> articles = [
    Article(
      title: 'News 1',
      description: 'this is news 1',
      imageUrl: 'assets/images/news.jpeg',
    ),
    Article(
      title: 'News 1',
      description: 'this is news 1',
      imageUrl: 'assets/images/news.jpeg',
    ),
    Article(
      title: 'News 1',
      description: 'this is news 1',
      imageUrl: 'assets/images/news.jpeg',
    ),
  ];


  @override
  void initState() {
    // getNewsData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("News App", style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.orange,
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.person,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyNewsScreen()));
              },
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              ListView.separated(
                  // physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return buildNoteModel(articles[index]);
                  },
                  itemCount: 3,
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                        height: 5,
                      )),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 200,
                  height: 50,
                  child: MaterialButton(
                    color: Colors.orange,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    onPressed: () {},
                    child: const Text(
                      "See More News",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Widget buildNoteModel(Article news) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: 600,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            boxShadow: const [BoxShadow(color: Colors.orange, blurRadius: 5)],
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.orange, width: 0.3),
            color: Colors.white),
        child: Row(
          children: [
            Image(
              image: AssetImage(news.imageUrl),
              width: 120,
              height: 120,
              fit: BoxFit.scaleDown,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    news.title,
                    style: const TextStyle(
                      fontSize: 20,
                      height: 1.5,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    news.description,
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                    maxLines: 2,
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.edit,
                color: Colors.amber,
              ),
            )
          ],
        ),
      ),
    );
  }
}
