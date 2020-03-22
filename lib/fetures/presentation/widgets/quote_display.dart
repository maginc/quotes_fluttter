import 'package:flutter/material.dart';
import 'package:quotesfluttter/fetures/data/model/daily_quote.dart';


/**
 *Created by Andris on 22-Mar-20
 */
class QuoteDisplay extends StatelessWidget {
  final DailyQuote dailyQuote;

  const QuoteDisplay({
    Key key,
    this.dailyQuote
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: Column(
        children: <Widget>[
          // Fixed size, doesn't scroll
          Text(
            dailyQuote.contents.quotes[0].author.toString(),
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
          // Expanded makes it fill in all the remaining space
          Expanded(
            child: Center(
              // Only the trivia "message" part will be scrollable
              child: SingleChildScrollView(
                child: Text(
                  dailyQuote.contents.quotes[0].quote.toString(),
                  style: TextStyle(fontSize: 25),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
