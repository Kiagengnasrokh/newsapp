class Article {
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;
  final String? author;  // Menambahkan field author
  final Source source;   // Menambahkan field source yang merupakan objek

  Article({
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
    this.author,
    required this.source,   // Memasukkan source ke konstruktor
  });

  // Menambahkan metode untuk mengonversi JSON ke objek Article
  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'],
      description: json['description'],
      url: json['url'],
      urlToImage: json['urlToImage'] ?? '',
      publishedAt: json['publishedAt'],
      content: json['content'] ?? '',
      author: json['author'],
      source: Source.fromJson(json['source']), // Mengonversi objek source
    );
  }
}

class Source {
  final String id;
  final String name;

  Source({required this.id, required this.name});

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }
}
