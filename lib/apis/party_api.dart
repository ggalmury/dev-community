import 'dart:convert';
import 'package:dev_community/apis/dio/dio_provider.dart';
import 'package:dev_community/models/party_article_creator.dart';
import 'package:dev_community/models/party_article.dart';
import 'package:dev_community/utils/exceptions/network_exception.dart';
import 'package:dio/dio.dart';

class PartyApi {
  final String path = "http://localhost:8080/party";

  Future<List<PartyArticle>> getArticle() async {
    Response response = await DioProvider().authDio.get("$path/articles");

    if (response.statusCode == 200) {
      List<dynamic> result = response.data;

      List<PartyArticle> articles = result.map((m) {
        return PartyArticle.fromJson(m);
      }).toList();

      return articles;
    } else {
      throw NetworkException();
    }
  }

  Future<bool> createArticle(
      PartyArticleCreator partyArticleCreateModel) async {
    Response response = await DioProvider().authDio.post("$path/create",
        data: jsonEncode(partyArticleCreateModel.toJson()));

    if (response.statusCode == 201) {
      return true;
    } else {
      throw NetworkException();
    }
  }
}
