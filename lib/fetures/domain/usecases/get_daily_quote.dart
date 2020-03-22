import 'package:dartz/dartz.dart';
import 'package:quotesfluttter/core/error/failures.dart';
import 'package:quotesfluttter/core/usecase/usecase.dart';
import 'package:quotesfluttter/fetures/data/model/daily_quote.dart';
import 'package:quotesfluttter/fetures/domain/repositorie/daily_quote_repository.dart';

class GetDailyQuote implements UseCase<DailyQuote, NoParams>{
  final DailyQuoteRepository repository;

  GetDailyQuote(this.repository);
  @override
  Future<Either<Failure, DailyQuote>> call(NoParams params) async {

    return await repository.getDailyQuote();
  }

}