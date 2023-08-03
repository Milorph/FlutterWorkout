import 'package:flutter/material.dart';
import 'book_service.dart';

class BookSearchScreen extends StatefulWidget {
  const BookSearchScreen({Key? key}) : super(key: key);

  @override
  BookSearchScreenState createState() => BookSearchScreenState();
}

class BookSearchScreenState extends State<BookSearchScreen> {
  final BookService _bookService = BookService();
  String _query = '';
  List<Map<String, dynamic>> _books = [];

  void _searchBooks() async {
    if (_query.isNotEmpty) {
      try {
        final List<Map<String, dynamic>> books =
            await _bookService.searchBooks(_query);
        setState(() {
          _books = books;
        });
      } catch (e) {
        // Handle API call error
        debugPrint('Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.yellow[100],
          elevation: 0,
          title: TextField(
            onChanged: (value) {
              setState(() {
                _query = value;
              });
            },
            onSubmitted: (_) => _searchBooks(),
            decoration: const InputDecoration(
              hintText: 'Search books...',
            ),
          ),
          actions: [
            IconButton(
              onPressed: _searchBooks,
              icon: const Icon(Icons.search),
              color: Colors.black,
            ),
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff9796f0), Color(0xfffbc7d4)],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0.1, 0.7], // Adjust the stops as per your preference
            ),
          ),
          child: ListView.builder(
            itemCount: _books.length,
            itemBuilder: (context, index) {
              final book = _books[index];
              // Extract the data from the 'book' map and display it in your ListTile or custom widget
              // For example: book['volumeInfo']['title'], book['volumeInfo']['authors'], etc.
              return ListTile(
                title: Text(book['volumeInfo']['title']),
                subtitle: Text(book['volumeInfo']['authors']?.join(', ') ??
                    'Unknown Author'),
                onTap: () {},
              );
            },
          ),
        ));
  }
}
