import 'package:flutter/material.dart';
import 'package:news_app/src/models/category_model.dart';
import 'package:news_app/src/services/news_service.dart';
import 'package:news_app/src/themes/darkTheme.dart';
import 'package:news_app/src/widgets/news_list.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            _CategoryList(),
            (newsService.getCategorySelectedArticles().length > 0)
                ? Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: NewsList(newsService.getCategorySelectedArticles()),
                    ),
                  )
                : Expanded(child: Center(child: CircularProgressIndicator()))
          ],
        ),
      ),
    );
  }
}

class _CategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NewsService>(context).categories;
    final traduction = Provider.of<NewsService>(context).categoriesTraduction;

    return Container(
      width: double.infinity,
      height: 80,
      child: ListView.builder(
        //Cambiar el comportamiento de la animacion scroll del listview
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: <Widget>[
                _CategoryButton(categories[index]),
                SizedBox(height: 5),
                Text(traduction[categories[index].name]),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final Category category;

  const _CategoryButton(this.category);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final newsService = Provider.of<NewsService>(context, listen: false);
        newsService.categorySelected = category.name;
      },
      child: Container(
        width: 40,
        height: 40,
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Consumer<NewsService>(
          builder: (context, NewsService service, Widget child) {
            return Icon(
              category.icon,
              color: category.name == service.categorySelected ? myTheme.accentColor : Colors.black54,
            );
          },
        ),
      ),
    );
  }
}
