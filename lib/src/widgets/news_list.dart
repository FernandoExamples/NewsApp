import 'package:flutter/material.dart';
import 'package:news_app/src/models/article.dart';
import 'package:url_launcher/url_launcher.dart';

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
      children: <Widget>[
        _TarjetaTopBar(
          noticia,
          index,
        ),
        _TarjetaTitutlo(noticia),
        _TarjetaImagen(noticia),
        _TarjetaBody(noticia),
        _TarjetaBotones(noticia),
        Divider(),
        SizedBox(height: 10),
      ],
    );
  }
}

class _TarjetaTopBar extends StatelessWidget {
  final Article noticia;
  final index;

  const _TarjetaTopBar(this.noticia, this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: <Widget>[
          Text('${index + 1} ', style: TextStyle(color: Theme.of(context).accentColor)),
          Text('${noticia.source}'),
        ],
      ),
    );
  }
}

class _TarjetaTitutlo extends StatelessWidget {
  final Article noticia;
  const _TarjetaTitutlo(this.noticia);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        noticia.title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _TarjetaImagen extends StatelessWidget {
  final Article noticia;

  const _TarjetaImagen(this.noticia);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
        child: noticia.urlToImage != null
            ? FadeInImage(
                placeholder: AssetImage('assets/img/giphy.gif'),
                image: NetworkImage(noticia.urlToImage),
              )
            : Image.asset('assets/img/no-image.png'),
      ),
    );
  }
}

class _TarjetaBody extends StatelessWidget {
  final Article noticia;

  const _TarjetaBody(this.noticia);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: <Widget>[
          InkWell(
            child: Text(noticia.description != null ? noticia.description : ''),
            onTap: () => _launchURL(noticia.url),
          ),
        ],
      ),
    );
  }
}

class _TarjetaBotones extends StatelessWidget {
  final Article noticia;

  const _TarjetaBotones(this.noticia);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
            onPressed: () {},
            fillColor: Theme.of(context).accentColor,
            textStyle: Theme.of(context).textTheme.button,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Icon(Icons.star_border),
          ),
          SizedBox(width: 20),
          RawMaterialButton(
            onPressed: () => _launchURL(noticia.url),
            fillColor: Colors.blue,
            textStyle: Theme.of(context).textTheme.button,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Icon(Icons.more),
          )
        ],
      ),
    );
  }
}

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    print('Could not launch $url');
  }
}
