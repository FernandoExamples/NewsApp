import 'package:flutter/material.dart';
import 'package:news_app/src/models/article.dart';
import 'package:news_app/src/routes.dart';

class NewsList extends StatelessWidget {
  final List<Article> news;

  const NewsList(this.news);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: news.length,
      itemBuilder: (context, index) {
        return Noticia(
          noticia: this.news[index],
          index: index,
        );
      },
    );
  }
}

class Noticia extends StatelessWidget {
  final Article noticia;
  final int index;

  const Noticia({@required this.noticia, @required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _CardTopBar(
          noticia,
          index,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(
            noticia.title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
        ),
        _CardImagen(noticia),
        _CardBotones(noticia),
        Divider(),
        SizedBox(height: 10),
      ],
    );
  }
}

class _CardTopBar extends StatelessWidget {
  final Article noticia;
  final index;

  const _CardTopBar(this.noticia, this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text('${index + 1} ', style: TextStyle(color: Theme.of(context).accentColor)),
          Text('${noticia.source}'),
        ],
      ),
    );
  }
}

class _CardImagen extends StatelessWidget {
  final Article noticia;

  const _CardImagen(this.noticia);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
        child: noticia.imageURL != null
            ? FadeInImage(
                placeholder: AssetImage('assets/img/giphy.gif'),
                image: NetworkImage(noticia.urlToImage),
              )
            : Image.asset('assets/img/no-image.png'),
      ),
    );
  }
}

class _CardBotones extends StatelessWidget {
  final Article noticia;

  const _CardBotones(this.noticia);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        onPressed: () => Navigator.of(context).pushNamed(Routes.DETAILS, arguments: noticia),
        child: Text('Leer más'),
        style: ElevatedButton.styleFrom(primary: Theme.of(context).accentColor, shape: StadiumBorder()),
      ),
    );
  }
}
