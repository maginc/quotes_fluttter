import 'package:dartz/dartz.dart';
import 'package:quotesfluttter/core/error/failures.dart';
import 'package:quotesfluttter/fetures/data/model/daily_quote.dart';

abstract class DailyQuoteRepository{
  Future<Either<Failure, DailyQuote>> getDailyQuote();
}