import 'package:dicoding_news_app/common/navigation.dart';
import 'package:dicoding_news_app/data/models/article.dart';
import 'package:dicoding_news_app/pages/pages.dart';
import 'package:dicoding_news_app/provider/database_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardArticle extends StatelessWidget {
  final Article article;

  const CardArticle({Key key, @required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isBookmarked(article.url),
          builder: (context, snapshot) {
            ///Mengecek apakah terdapat data atau dari kembalian future
            ///jika tidak maka nilai isBookmarked = false
            var isBookmarked = snapshot.data ?? false;
            return Material(
              child: ListTile(
                trailing: isBookmarked
                    ? IconButton(
                        icon: Icon(Icons.bookmark),
                        onPressed: () => provider.removeBookmark(article.url),
                      )
                    : IconButton(
                        icon: Icon(Icons.bookmark_border),
                        onPressed: () => provider.addBookmark(article),
                      ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                leading: article.urlToImage == null
                    ? Container(
                        width: 100,
                        child: Icon(Icons.error),
                      )
                    : Hero(
                        tag: article.urlToImage,
                        child: Image.network(
                          article.urlToImage,
                          width: 100,
                        ),
                      ),
                title: Text(article.title ?? ''),
                subtitle: Text(article.author ?? ''),
                onTap: () {
                  Navigation.intentWithData(
                      ArticleDetailPage.routeName, article);
                },
              ),
            );
          },
        );
      },
    );
  }
}
