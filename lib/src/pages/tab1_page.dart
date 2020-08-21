import 'package:flutter/material.dart';
import 'package:news_app/src/services/news_service.dart';
import 'package:news_app/src/widgets/news_list.dart';
import 'package:provider/provider.dart';

class Tab1Page extends StatefulWidget {
  const Tab1Page({Key key}) : super(key: key);

  @override
  _Tab1PageState createState() => _Tab1PageState();
}

///El mixin es para que no pierda el estado de la pagina al cambiar de tab
///Esto para no perder el scroll.
class _Tab1PageState extends State<Tab1Page> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    final headlines = Provider.of<NewsService>(context).headLines;

    return SafeArea(
      child: Scaffold(
        body: (headlines.length == 0)
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.only(top: 10),
                child: NewsList(headlines),
              ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
