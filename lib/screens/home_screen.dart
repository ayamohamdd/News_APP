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
  @override
  void initState() {
    super.initState();
  }

  List<Article> articles = [
    Article(
      title: 'Article 1',
      description: 'this is article 1',
      imageUrl: 'assets/images/news.jpeg',
    ),
    Article(
      title: 'Article 2',
      description: 'this is article 2',
      imageUrl: 'assets/images/news.jpg',
    ),
    Article(
      title: 'Article 3',
      description: 'this is article 3',
      imageUrl: 'assets/images/News (1).jpg',
    ),
    Article(
      title: 'Article 4',
      description: 'this is article 4',
      imageUrl: 'assets/images/PJ_2016.07.07_Modern-News-Consumer_0-01.webp',
    ),
    Article(
      title: 'Article 5',
      description: 'this is article 5',
      imageUrl:
          'assets/images/news-newspapers-folded-stacked-word-wooden-block-puzzle-dice-concept-newspaper-media-press-release-42301371.png',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
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
                  itemBuilder: (context, index) {
                    return buildNoteModel(articles[index]);
                  },
                  itemCount: 5,
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

  Widget buildNoteModel(Article article) {
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
              image: AssetImage(article.imageUrl),
              width: 130,
              height: 120,
              fit: BoxFit.cover,
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
                    article.title,
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
                    article.description,
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
