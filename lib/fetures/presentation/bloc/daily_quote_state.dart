import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:quotesfluttter/fetures/data/model/daily_quote.dart';

abstract class DailyQuoteState extends Equatable{
  @override
  List<Object> get props => [];
}

class Empty extends DailyQuoteState{}

class Loading extends DailyQuoteState{}

class Loaded extends DailyQuoteState{
  final DailyQuote dailyQuote;

  Loaded({@required this.dailyQuote});

  @override
  List<Object> get props => [dailyQuote];
}

class Error extends DailyQuoteState{
  final String message;

  Error({@required this.message});

  @override
  List<Object> get props => [message];


}