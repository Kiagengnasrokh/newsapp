import 'package:flutter/material.dart';
import '../models/article.dart';

class NewsDetailPage extends StatelessWidget {
  final Article article;

  NewsDetailPage({required this.article});

  @override
  Widget build(BuildContext context) {
    // Konversi waktu terbit artikel menjadi format yang mudah dibaca
    String formattedDate = '';
    if (article.publishedAt != null) {
      final dateTime = DateTime.parse(article.publishedAt!);
      formattedDate = "${dateTime.day}-${dateTime.month}-${dateTime.year} ${dateTime.hour}:${dateTime.minute}";
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          "NEWS DETAIL",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              article.urlToImage != null && article.urlToImage!.isNotEmpty
                  ? Image.network(
                      article.urlToImage!,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      width: double.infinity,
                      height: 200,
                      color: Colors.grey,
                      child: Icon(Icons.broken_image, color: Colors.white),
                    ),
              SizedBox(height: 16),
              Text(
                article.title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              // Menampilkan waktu terbit
              Text(
                'Published: $formattedDate',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              SizedBox(height: 8),
              Text(
                article.description ?? 'No description available.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                article.content ?? 'No content available.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                'Source: ${article.source?.name ?? 'Unknown Source'}',
                style: TextStyle(fontSize: 14, color: Colors.blue),
              ),
              SizedBox(height: 8),
              Text(
                'Read more: ${article.url}',
                style: TextStyle(fontSize: 14, color: Colors.blue),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
