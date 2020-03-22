import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:quotesfluttter/core/error/exceptions.dart';
import 'package:quotesfluttter/fetures/data/model/daily_quote.dart';

abstract class DailyQuoteRemoteDataSource {
  Future<DailyQuote> getDailyQuote();
}

class DailyQuoteRemoteDataSourceImpl implements DailyQuoteRemoteDataSource {
  final http.Client client;

  DailyQuoteRemoteDataSourceImpl({@required this.client});

  @override
  Future<DailyQuote> getDailyQuote() =>
      _getDailyQuoteFromUrl('https://quotes.rest/qod?language=en');

  Future<DailyQuote> _getDailyQuoteFromUrl(String url) async {
    final response =
        await client.get(url, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      return DailyQuote.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
