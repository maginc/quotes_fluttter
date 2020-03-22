import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotesfluttter/core/error/failures.dart';
import 'package:quotesfluttter/core/usecase/usecase.dart';
import 'package:quotesfluttter/fetures/data/model/daily_quote.dart';
import 'package:quotesfluttter/fetures/domain/usecases/get_daily_quote.dart';
import 'package:quotesfluttter/fetures/presentation/bloc/bloc.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class DailyQuoteBloc extends Bloc<QuoteEvent, DailyQuoteState>{

  final GetDailyQuote getDailyQuote;

  DailyQuoteBloc({
    @required GetDailyQuote dailyQuote
  }) : assert (dailyQuote != null),
       getDailyQuote = dailyQuote ;

  @override
  DailyQuoteState get initialState => Empty();

  @override
  Stream<DailyQuoteState> mapEventToState(QuoteEvent event) async* {
    yield Loading();
    final failureOrQuote = await getDailyQuote(NoParams());
    yield* _eitherLoadOrErrorState(failureOrQuote);

  }

  Stream<DailyQuoteState> _eitherLoadOrErrorState(
      Either<Failure, DailyQuote> failureOrQuote
      ) async* {
    yield failureOrQuote.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (quote)=> Loaded(dailyQuote: quote)
    );
  }


  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }

}