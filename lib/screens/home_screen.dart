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
  Future<List<Article>> getNewsData() async {
    Response response = await DioHelper.getData(
        url: 'https://newsapi.org/v2/top-headlines',
        query: {'country': 'us', 'apiKey': '7ce48a7bff0c4cb98475a703a3e942b2'});
    Articles articlesData = Articles.fromJson(response.data);
    List<Article> articles = articlesData.articles;
    return articles;
  }

  @override
  void initState() {
    getNewsData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: FutureBuilder<List<Article>>(
          future: getNewsData(),
          builder: (context, AsyncSnapshot<List<Article>> snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                // physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  Article article = snapshot.data![index];
                  return buildNoteModel(article);
                },
                itemCount: snapshot.data!.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(
                  height: 5,
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.orangeAccent,
              ),
            );
          }),
    );
  }

  Widget buildNoteModel(Article news) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            boxShadow: const [BoxShadow(color: Colors.orange, blurRadius: 5)],
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.orange, width: 0.3),
            color: Colors.white),
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.center,
                //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(15)),
                    child: Image(
                      image: NetworkImage(news.imageUrl!),
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 200,
                        child: Text(
                          '${news.title}',
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
                          '${news.description}',
                          style: const TextStyle(
                            fontSize: 10.0,
                          ),
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Edit
            // IconButton(
            //   onPressed: () {},
            //   icon: const Icon(Icons.edit),
            // )
          ],
        ),
      ),
    );
  }
}
