import 'package:flutter/material.dart';
import 'package:news_app/src/models/category.dart';
import 'package:news_app/src/providers/news_provider.dart';
import 'package:news_app/src/themes/dark_theme.dart';
import 'package:news_app/src/widgets/news_list.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            _CategoryList(),
            newsProvider.getCategorySelectedArticles().length > 0
                ? Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
                      child: NewsList(newsProvider.getCategorySelectedArticles()),
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
    final categories = Provider.of<NewsProvider>(context).categories;
    final traduction = Provider.of<NewsProvider>(context).categoriesTraduction;

    return Container(
      width: double.infinity,
      height: 80,
      child: ListView.builder(
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
        final provider = Provider.of<NewsProvider>(context, listen: false);
        provider.categorySelected = category.name;
      },
      child: Container(
        width: 40,
        height: 40,
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Consumer<NewsProvider>(
          builder: (context, NewsProvider provider, Widget child) {
            return Icon(
              category.icon,
              color: category.name == provider.categorySelected ? darkTheme.accentColor : Colors.black54,
            );
          },
        ),
      ),
    );
  }
}
