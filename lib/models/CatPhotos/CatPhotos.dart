import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class CatPhotos with ChangeNotifier {
  List<String> images = [];

  bool isLoading = true;

  Future<void> load() async {
    final res = await http.get(
      'https://api.thecatapi.com/v1/images/search?limit=10&order=RANDOM',
      headers: {"x-api-key": DotEnv().env['API_KEY']},
    );
    final data = jsonDecode(res.body) as List;

    this.images.addAll(data.map((e) => e["url"] as String).toList());
    isLoading = false;
    notifyListeners();
  }

  CatPhotos() {
    this.load();
  }
}
