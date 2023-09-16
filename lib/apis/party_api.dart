import 'dart:convert';
import 'package:dev_community/models/party_article_creator.dart';
import 'package:dev_community/models/party_article.dart';
import 'package:dev_community/utils/exceptions/network_exception.dart';
import 'package:http/http.dart';

class PartyApi {
  final String path = "http://localhost:8080/party";

  Future<List<PartyArticle>> getArticle() async {
    Response response = await get(Uri.parse("$path/articles"));

    if (response.statusCode == 200) {
      List<dynamic> rawResult = jsonDecode(response.body);

      List<PartyArticle> articles = rawResult.map((m) {
        return PartyArticle.fromJson(m);
      }).toList();

      return articles;
    } else {
      throw NetworkException("Failed to load party article list");
    }
  }

  Future<bool> createArticle(
      PartyArticleCreator partyArticleCreateModel) async {
    Response response = await post(Uri.parse("$path/create"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(partyArticleCreateModel.toJson()));

    if (response.statusCode == 201) {
      return true;
    } else {
      throw NetworkException("Failed to create party article");
    }
  }
}
