import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotesfluttter/fetures/presentation/bloc/bloc.dart';

/**
 *Created by Andris on 22-Mar-20
 */
class DailyQuoteControls extends StatefulWidget {
  DailyQuoteControls({
    Key key
  }) : super(key: key);

  @override
  _DailyQuoteControlsState createState() => _DailyQuoteControlsState();
}

class _DailyQuoteControlsState extends State<DailyQuoteControls> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(


        ),
        SizedBox(height: 10),
        Row(
          children: <Widget>[
            SizedBox(width: 10),
            Expanded(
              child: RaisedButton(
                child: Text('Get quote of the day'),
                onPressed: dispatchQuoteOfTheDay,
              ),
            ),
          ],
        )
      ],
    );
  }

  void dispatchQuoteOfTheDay() {
    BlocProvider.of<DailyQuoteBloc>(context).add(GetQuoteOfTheDay());

  }
}