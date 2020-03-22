import 'package:flutter/material.dart';
import 'package:quotesfluttter/fetures/presentation/pages/daily_quote_page.dart';
import 'injection_container.dart' as di;


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily quote',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DailyQuotePage(),
    );
  }
}

