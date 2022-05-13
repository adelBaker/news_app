import 'package:flutter/material.dart';
import 'package:news_app2/model/article.dart';

class NewsDetails extends StatelessWidget {

  Article article;
  NewsDetails(this.article);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(article.urlToImage),
                      fit: BoxFit.cover
                    )
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Text(article.title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),textAlign: TextAlign.start,),
                      const SizedBox(height: 4),
                      Text(article.author,style: TextStyle(fontSize: 13),textAlign: TextAlign.start,),
                      const SizedBox(height: 4),
                      Text(article.publishedAt,style: TextStyle(fontSize: 13),textAlign: TextAlign.start,),
                      const Divider(height: 20,color: Colors.black,),
                      Text(article.content,style: TextStyle(fontSize: 15),textAlign: TextAlign.start,),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}
