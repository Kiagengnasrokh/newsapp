import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article.dart'; // Pastikan path sudah benar

class NewsService {
  static const String _apiKey = '73290c41c2c2447f9a91faa2a7cd2806';
  static const String _baseUrl = 'https://newsapi.org/v2';

  // Menambahkan kategori pada API request untuk berita populer
  Future<List<Article>> fetchArticlesWithImages({String category = 'general'}) async {
    final response = await http
        .get(Uri.parse('$_baseUrl/top-headlines?category=$category&apiKey=$_apiKey'));

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      List<dynamic> body = json['articles'];

      // Filter artikel yang memiliki gambar (urlToImage)
      List<Article> articles = body
          .where((dynamic item) =>
              item['urlToImage'] != null && item['urlToImage'].isNotEmpty)
          .map((dynamic item) => Article.fromJson(item))
          .toList();

      return articles;
    } else {
      throw Exception('Failed to load articles with images');
    }
  }

  // Fetch berita terbaru tanpa kategori
  Future<List<Article>> fetchLatestArticlesWithImages() async {
    final response =
        await http.get(Uri.parse('$_baseUrl/top-headlines?country=us&apiKey=$_apiKey'));

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      List<dynamic> body = json['articles'];

      // Filter artikel yang memiliki gambar (urlToImage)
      List<Article> articles = body
          .where((dynamic item) =>
              item['urlToImage'] != null && item['urlToImage'].isNotEmpty)
          .map((dynamic item) => Article.fromJson(item))
          .toList();

      return articles;
    } else {
      throw Exception('Failed to load latest articles with images');
    }
  }

  // Menambahkan fungsi untuk pencarian artikel berdasarkan judul
  Future<List<Article>> searchArticlesByTitle(String query) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/everything?q=$query&apiKey=$_apiKey'),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      List<dynamic> body = json['articles'];

      // Filter artikel yang memiliki gambar (urlToImage)
      List<Article> articles = body
          .where((dynamic item) =>
              item['urlToImage'] != null && item['urlToImage'].isNotEmpty)
          .map((dynamic item) => Article.fromJson(item))
          .toList();

      return articles;
    } else {
      throw Exception('Failed to load articles based on search query');
    }
  }
}
