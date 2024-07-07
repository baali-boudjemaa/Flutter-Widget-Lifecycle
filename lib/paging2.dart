import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'Articles.dart';

void main() {
  runApp(const MyApp());
}

//pagination in flutter
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Scaler News Portal',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _baseUrl =
      'https://newsapi.org/v2/top-headlines?country=in&apiKey=5e77d963853940e0bb189cc1257d3d28';
  int _page = 1;
  final int _pageSize = 5;

  bool _hasNextPage = true;
  bool _isLoading = false;

  List<Article> _articles = [];
  final _scrollController = ScrollController();
  void _loadMoreData() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      setState(() {
        _page++;
        _fetchArticles();
      });
    }
  }
  Future<void> _fetchArticles() async {
    setState(() {
      _isLoading = true;
    });

      print("$_page");
      final url = '$_baseUrl&page=$_page&pageSize=$_pageSize';
      final response = await http.get(Uri.parse(url));
      final responseData = json.decode(response.body);

      setState(() {
        _articles.addAll(Articles.fromJson(responseData).articles);
        print(url);
        _hasNextPage = (_page < responseData['totalResults'] ~/ _pageSize);
      });


    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_loadMoreData);
    _fetchArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scaler News Portal'),
      ),
      body
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              controller: _scrollController,
              itemCount: _articles.length,
              itemBuilder: (ctx, index) {
                final article = _articles[index];
                final title = article.title ?? 'No Title';
                final description =
                    article.description ?? 'No Description';

                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: article.urlToImage != null
                        ? Image.network(
                      article.urlToImage!,
                      width: 120,
                      height: 80,
                      fit: BoxFit.values.last,
                    )
                        : Container(
                      width: 80,
                      height: 80,
                      color: Colors.grey,
                    ),
                    title: Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                );
              },
            ),
          ),
          if (_hasNextPage)
            ElevatedButton(
              onPressed: _fetchArticles,
              child: const Text('Load More'),
            ),
        ],
      ),
    );
  }
}
