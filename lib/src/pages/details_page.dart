import 'package:flutter/material.dart';
import 'package:news_app/src/models/article.dart';
import 'package:news_app/src/providers/news_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final article = ModalRoute.of(context).settings.arguments as Article;
    print(article.toMap());

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(article),
          SliverList(
            delegate: SliverChildListDelegate([
              _buildAuthor(article),
              _buildDescription(article, context),
              SizedBox(height: 20),
              _buildBottomList(context),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(Article article) {
    return SliverAppBar(
      centerTitle: true,
      elevation: 2,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200,
      floating: true,
      pinned: false,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(article.title, style: TextStyle(fontSize: 14)),
        titlePadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
        background: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image:
                  article.urlToImage != null ? NetworkImage(article.urlToImage) : AssetImage('assets/img/no-image.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(color: Colors.black.withOpacity(0.4)),
        ),
      ),
    );
  }

  Widget _buildDescription(Article article, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Column(
        children: [
          Text(article.description ?? ''),
          SizedBox(height: 10),
          Text(article.content ?? ''),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 10),
            child: ElevatedButton(
              onPressed: () => _launchURL(article.url),
              child: Text('Seguir leyendo'),
              style: ElevatedButton.styleFrom(primary: Theme.of(context).buttonColor, shape: StadiumBorder()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAuthor(Article article) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(article.source ?? ''),
          SizedBox(height: 5),
          Row(
            children: [
              Text(article.author ?? 'Anónimo'),
              SizedBox(width: 5),
              Text('|'),
              SizedBox(width: 5),
              Text(article.publishedAt.toString().substring(0, 10)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomList(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context, listen: false);

    List<Widget> articles = [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text('Te puede interesar...'),
      ),
    ];

    newsProvider.headLines.forEach((article) {
      articles.add(
        ListTile(
          onTap: () => _launchURL(article.url),
          title: Text(article.title),
          trailing:
              article.urlToImage != null ? Image.network(article.urlToImage) : Image.asset('assets/img/no-image.png'),
        ),
      );
      articles.add(Divider());
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: articles,
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }
}
