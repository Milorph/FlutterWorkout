import 'dart:convert';
import 'package:http/http.dart' as http;

class BookService {
  final String _baseUrl = 'https://www.googleapis.com/books/v1/volumes';

  Future<List<Map<String, dynamic>>> searchBooks(String query) async {
    final response = await http.get(Uri.parse('$_baseUrl?q=$query'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      return List<Map<String, dynamic>>.from(jsonData['items']);
    } else {
      throw Exception('Failed to load books');
    }
  }
}
