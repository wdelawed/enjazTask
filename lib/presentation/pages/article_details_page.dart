import 'package:flutter/material.dart';
import 'package:interviewtask/domain/enitities/news_article.dart';

class ArticleDetails extends StatelessWidget {
  final NewsArticle article;
  const ArticleDetails({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                article.imageUrl,
                fit: BoxFit.fitWidth,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, left: 16, right: 16),
              child: Text(
                article.name,
                style: const TextStyle(fontSize: 20, color: Colors.black87),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, left: 16, right: 16),
              child: Text(
                article.description,
                style: const TextStyle(fontSize: 16, color: Colors.black45),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
