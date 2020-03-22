import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotesfluttter/fetures/presentation/bloc/bloc.dart';
import 'package:quotesfluttter/fetures/presentation/widgets/daily_quote_controls.dart';
import 'package:quotesfluttter/fetures/presentation/widgets/message_display.dart';
import 'package:quotesfluttter/fetures/presentation/widgets/loading_widget.dart';
import 'package:quotesfluttter/fetures/presentation/widgets/quote_display.dart';
import 'package:quotesfluttter/injection_container.dart';

/**
 Created by Andris on 22-Mar-20
 **/
class DailyQuotePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily quote'),
      ),
      body: buildBody(context),
    );
  }

  BlocProvider<DailyQuoteBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<DailyQuoteBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              // Top half
              BlocBuilder<DailyQuoteBloc, DailyQuoteState>(
                // ignore: missing_return
                builder: (context, state) {
                  if (state is Empty) {
                    return MessageDisplay(
                      message: 'Start searching!',
                    );
                  } else if (state is Loading) {
                    return LoadingWidget();
                  } else if (state is Loaded) {
                    return QuoteDisplay(dailyQuote: state.dailyQuote);
                  } else if (state is Error) {
                    return MessageDisplay(
                      message: state.message,
                    );
                  }
                },
              ),
              SizedBox(height: 20),
              // Bottom half
              DailyQuoteControls()
            ],
          ),
        ),
      ),
    );
  }
}
