import 'dart:convert';
import 'package:dev_community/models/party_article_create_model.dart';
import 'package:dev_community/models/party_article_model.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class PartyApi {
  final String path = "http://localhost:8080/party";

  Future<List<PartyArticleModel>> getArticle() async {
    Response response = await http.get(Uri.parse("$path/articles"));

    if (response.statusCode == 200) {
      List<dynamic> rawResult = jsonDecode(response.body)["result"];

      List<PartyArticleModel> result = rawResult.map((m) {
        return PartyArticleModel.fromJson(m);
      }).toList();

      return result;
    } else {
      throw Exception("Failed to load party article list");
    }
  }

  Future<bool> createArticle(
      PartyArticleCreateModel partyArticleCreateModel) async {
    Response response = await http.post(Uri.parse("$path/create"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(partyArticleCreateModel.toJson()));

    // temp
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
