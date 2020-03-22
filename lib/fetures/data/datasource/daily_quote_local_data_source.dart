import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:quotesfluttter/core/error/exceptions.dart';
import 'package:quotesfluttter/fetures/data/model/daily_quote.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class DailyQuoteLocalDataSource {
  Future<DailyQuote> getLastDailyQuote();
  Future<void> cacheDailyQuote(DailyQuote quoteToCache);
}

const CACHED_DAILY_QUOTE = 'CACHED_DAILY_QUOTE';

class DailyQuoteLocalDataSourceImpl implements DailyQuoteLocalDataSource{
  final SharedPreferences sharedPreferences;

  DailyQuoteLocalDataSourceImpl({@required this.sharedPreferences});


  @override
  Future<void> cacheDailyQuote(DailyQuote quoteToCache) {
    return sharedPreferences.setString(
      CACHED_DAILY_QUOTE,
      json.encode(quoteToCache.toJson())
    );
  }

  @override
  Future<DailyQuote> getLastDailyQuote() {
   final jsonString = sharedPreferences.getString(CACHED_DAILY_QUOTE);
   if (jsonString != null) {
     return Future.value(DailyQuote.fromJson(json.decode(jsonString)));
   }  else {
     throw CacheException();
   }
  }
}