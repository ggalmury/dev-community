import 'dart:convert';
import 'package:dev_community/apis/dio/dio_provider.dart';
import 'package:dev_community/models/party_article_create.dart';
import 'package:dev_community/models/party_article.dart';
import 'package:dev_community/models/party_comment_create.dart';
import 'package:dev_community/utils/exceptions/bad_request_exception.dart';
import 'package:dev_community/utils/exceptions/network_exception.dart';
import 'package:dev_community/utils/logger.dart';
import 'package:dio/dio.dart';

class PartyApi {
  final String path = "http://localhost:8080/party";

  Future<List<PartyArticle>> getArticle() async {
    Response response = await DioProvider().authDio.get("$path/articles");

    if (response.statusCode == 200) {
      List<dynamic> result = response.data["parties"];

      List<PartyArticle> articles = result.map((m) {
        return PartyArticle.fromJson(m);
      }).toList();

      return articles;
    } else {
      throw NetworkException();
    }
  }

  Future<bool> createArticle(PartyArticleCreate partyArticleCreate) async {
    Response response = await DioProvider()
        .authDio
        .post("$path/create", data: jsonEncode(partyArticleCreate.toJson()));

    if (response.statusCode == 201) {
      return true;
    } else {
      throw NetworkException();
    }
  }

  Future<void> getComment() async {
    // implement
  }

  Future<void> createComment(PartyCommentCreate partyCommentCreate) async {
    Response response = await DioProvider()
        .authDio
        .post("$path/comment-create", data: jsonEncode(partyCommentCreate));

    if (response.statusCode == 201) {
      loggerNoStack.i(response.data["comment"]);
    } else if (response.statusCode == 400) {
      throw BadRequestException();
    } else {
      throw NetworkException();
    }
  }
}
