import 'package:flutter/material.dart';

class Articles {
  List<Article> articles = [];
  // Articles.fromJson(Map<String,dynamic> json){
  //   json["articles"].forEach((element){
  //     articles.add(Article.fromJson(element));
  //   });
  //}
}

class Article {
  final String title;
  final String description;
  final String imageUrl;
  Article(
      {required this.title, required this.description, required this.imageUrl});
  //  Article.fromJson(Map<String, dynamic> json){
  //   title = json["title"];
  //   description = json["description"];
  //   imageUrl = json["urlToImage"];
  //  }
}
