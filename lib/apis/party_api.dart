import 'dart:convert';
import 'package:dev_community/models/party_article_create_model.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class PartyApi {
  final String path = "http://localhost:8080/party";

  Future<bool> createArticle(
      PartyArticleCreateModel partyArticleCreateModel) async {
    Response response = await http.post(Uri.parse("$path/create"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(partyArticleCreateModel.toJson()));

    // temp
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
