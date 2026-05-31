import 'package:flutter/material.dart';
import '../models/article_site.dart';
import 'web_view_page.dart';

class ArticleSitesPage extends StatelessWidget {
  const ArticleSitesPage({super.key});

  static const List<ArticleSite> sites = [
    ArticleSite(
      title: 'DNS Клуб',
      description:
          'Блог DNS с материалами про технику, комплектующие и электронику.',
      url: 'https://club.dns-shop.ru/blog/',
    ),
    ArticleSite(
      title: 'iXBT',
      description:
          'Новости и обзоры компьютерной техники, смартфонов и гаджетов.',
      url: 'https://www.ixbt.com/',
    ),
    ArticleSite(
      title: '3DNews',
      description:
          'Публикации о технологиях, железе, смартфонах и IT-индустрии.',
      url: 'https://3dnews.ru/',
    ),
    ArticleSite(
      title: 'Mobile-Review',
      description:
          'Статьи, обзоры и новости о смартфонах и мобильной электронике.',
      url: 'https://mobile-review.com/',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Статьи об электронике'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(20),
          itemCount: sites.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final site = sites[index];

            return Card(
              child: ListTile(
                leading: const Icon(Icons.article, size: 36),
                title: Text(site.title),
                subtitle: Text(site.description),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WebViewPage(site: site),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
