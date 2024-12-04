import 'package:flutter/material.dart';
import 'package:news_app/services/news_service.dart';
import 'package:news_app/models/article.dart';
import 'news_detail_page.dart'; // Pastikan path NewsDetailPage sudah benar

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  late Future<List<Article>> searchResults;

  @override
  void initState() {
    super.initState();
    searchResults = Future.value([]); // Menyiapkan default empty state
  }

  // Fungsi untuk melakukan pencarian berita
  void _searchArticles() {
    if (_searchController.text.isNotEmpty) {
      setState(() {
        searchResults =
            NewsService().searchArticlesByTitle(_searchController.text);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          'Cari Berita',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            // Kolom pencarian ditempatkan di bawah header
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        labelText: 'Masukkan Judul Berita...',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onSubmitted: (value) => _searchArticles(),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: _searchArticles,
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Menampilkan hasil pencarian
            FutureBuilder<List<Article>>(
              future: searchResults,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                      child: Text('Error: ${snapshot.error}',
                          style: TextStyle(color: Colors.red)));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Text(
                      'Tidak ada hasil untuk "${_searchController.text}".',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                } else {
                  List<Article> articles = snapshot.data!;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: articles.length,
                      itemBuilder: (context, index) {
                        final article = articles[index];
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          elevation: 5,
                          color: Colors.white,
                          child: ListTile(
                            contentPadding: EdgeInsets.all(10),
                            title: Text(
                              article.title,
                              style: TextStyle(fontWeight: FontWeight.bold),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Text(
                              article.source?.name ?? 'Unknown Source',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: Icon(Icons.arrow_forward),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NewsDetailPage(
                                      article: article), // Navigasi ke detail berita
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
