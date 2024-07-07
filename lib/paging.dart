import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const int _pageSize = 5;
  int _currentPage = 1;
  List<String> _data = [];

  bool _isLoading = false;
  final _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_loadMoreData);
    newData = List<String>.generate(
      10,
          (index) {
        return 'Item ${(index + 1) + (_currentPage - 1) * _pageSize}';
      },
    );
    _data.addAll(newData);

  }
  var newData;


  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
    });

    // Simulated fetching logic
    await Future.delayed(const Duration(seconds: 1));

    // Generate data for the current page

    newData = List<String>.generate(
      _pageSize,
          (index) {
          print("Item ${(index + 1) + (_currentPage - 1) * _pageSize}");
            return 'Item ${(index + 1) + (_currentPage - 1) * _pageSize}';
          },
    );
    setState(() {
      _data.addAll(newData);
      _isLoading = false;
    });
  }

  void _loadMoreData() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      setState(() {
        _currentPage++;
        _fetchData();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Load More Button'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              controller: _scrollController,
              itemCount: _data.length,
              itemBuilder: (context, index) {
                return Container(
                  height: 80,
                  child: ListTile(
                    title: Text(_data[index]),
                  ),
                );
              },
            ),
          ),
          _isLoading
              ? const Center(
            child: CircularProgressIndicator(),
          )
              : ElevatedButton(
            onPressed: _loadMoreData,
            child: const Text('Load More'),
          ),
        ],
      ),
    );
  }
}