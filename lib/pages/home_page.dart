import 'package:flutter/material.dart';
import 'package:news_app/pages/news_detail_page.dart';
import 'package:news_app/pages/search_page.dart';
import 'package:news_app/pages/about_page.dart';
import '../models/article.dart';
import '../services/news_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Article>> latestArticlesWithImages;
  late Future<List<Article>> popularArticlesWithImages;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    final newsService = NewsService();
    latestArticlesWithImages = newsService.fetchLatestArticlesWithImages();
    popularArticlesWithImages =
        newsService.fetchArticlesWithImages(category: 'technology');
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SearchPage()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AboutPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          'MAK NEWS',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bagian "Berita Terbaru"
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Berita Populer',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            FutureBuilder<List<Article>>(
              future: popularArticlesWithImages,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error: ${snapshot.error}',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Text(
                      'No articles with images available.',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                } else {
                  List<Article> articles = snapshot.data!;
                  return Container(
                    height: 240,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: articles.length,
                      itemBuilder: (context, index) {
                        final article = articles[index];
                        return Container(
                          width: 170,
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          child: Card(
                            elevation: 5,
                            color: Colors.white,
                            child: Column(
                              children: [
                                article.urlToImage != null &&
                                        article.urlToImage.isNotEmpty
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          topRight: Radius.circular(8),
                                        ),
                                        child: Image.network(
                                          article.urlToImage,
                                          width: 162,
                                          height: 107,
                                          fit: BoxFit.cover,
                                          loadingBuilder: (context, child,
                                              loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            } else {
                                              return Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            }
                                          },
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Icon(Icons.broken_image,
                                                size: 100, color: Colors.grey);
                                          },
                                        ),
                                      )
                                    : Icon(Icons.broken_image,
                                        size: 100, color: Colors.grey),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        article.title,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        article.source?.name ??
                                            'Unknown Source',
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.grey),
                                      ),
                                      SizedBox(height: 4),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  NewsDetailPage(
                                                      article: article),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          'Baca Selengkapnya',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),

            // Bagian "Berita Populer"
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Berita Terbaru',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            FutureBuilder<List<Article>>(
              future: latestArticlesWithImages,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error: ${snapshot.error}',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Text(
                      'No popular articles with images available.',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                } else {
                  List<Article> articles = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: articles.length,
                    itemBuilder: (context, index) {
                      final article = articles[index];
                      return Card(
                        margin:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        color: Colors.white,
                        child: ListTile(
                          leading: article.urlToImage != null &&
                                  article.urlToImage.isNotEmpty
                              ? Image.network(
                                  article.urlToImage,
                                  width: 80,
                                  fit: BoxFit.cover,
                                )
                              : Icon(Icons.broken_image, color: Colors.grey),
                          title: Text(
                            article.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            article.source?.name ?? 'Unknown Source',
                            style: TextStyle(color: Colors.grey),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    NewsDetailPage(article: article),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.blueGrey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Pencarian',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Tentang',
          ),
        ],
      ),
    );
  }
}
