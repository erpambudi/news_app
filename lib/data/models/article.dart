class ArticlesResult {
  String status;
  int totalResults;
  List<Article> articles;

  ArticlesResult({
    this.status,
    this.totalResults,
    this.articles,
  });

  ///data Json diubah ke dalam bentuk model ArticlesResult
  factory ArticlesResult.fromJson(Map<String, dynamic> json) => ArticlesResult(
        status: json["status"],
        totalResults: json["totalResults"],
        articles: List<Article>.from(
            json["articles"].map((x) => Article.fromJson(x))),
      );

  ///data model diubah ke dalam bentuk Json
  Map<String, dynamic> toJson() => {
        "status": status,
        "totalResults": totalResults,
        "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
      };
}

class Article {
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  DateTime publishedAt;
  String content;

  Article({
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        author: json["author"],
        title: json["title"],
        description: json["description"],
        url: json["url"],
        urlToImage: json["urlToImage"],
        publishedAt: DateTime.parse(json["publishedAt"]),
        content: json["content"] == null ? null : json["content"],
      );

  Map<String, dynamic> toJson() => {
        "author": author == null ? null : author,
        "title": title,
        "description": description == null ? null : description,
        "url": url,
        "urlToImage": urlToImage == null ? null : urlToImage,
        "publishedAt": publishedAt.toIso8601String(),
        "content": content == null ? null : content,
      };
}

///Kita perlu menambahkan fungsi toJson() untuk melakukan perubahan data dari model untuk ditampilkan menjadi JSON.
///Mengapa demikian? Karena untuk mengirimkan data dari notifikasi ke halaman tertentu pada parameter payload
///haruslah dalam bentuk String. Sehingga, kita perlu mengembalikan data terlebih dahulu dalam bentuk Json
///agar bisa mengirimkan data yang bersumber dari API kedalam parameter payload.
