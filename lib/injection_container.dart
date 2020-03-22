import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:quotesfluttter/fetures/data/repositories/daily_quote_repository_impl.dart';
import 'package:quotesfluttter/fetures/presentation/bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/platform/network_info.dart';
import 'fetures/data/datasource/daily_quote_local_data_source.dart';
import 'fetures/data/datasource/daily_quote_remote_data_source.dart';
import 'fetures/domain/repositorie/daily_quote_repository.dart';
import 'fetures/domain/usecases/get_daily_quote.dart';
import 'package:http/http.dart' as http;

final serviceLocator = GetIt.instance;

Future<void> init() async {

  //Bloc
  serviceLocator.registerFactory(()=> DailyQuoteBloc(
    dailyQuote: serviceLocator()
  )
  );

  //Use case
  serviceLocator.registerLazySingleton(()=> GetDailyQuote(serviceLocator()));

  //Repository
  serviceLocator.registerLazySingleton<DailyQuoteRepository>(
      ()=> DailyQuoteRepositoryImpl(
        dailyQuoteLocalDataSource: serviceLocator(),
        networkInfo: serviceLocator(),
        dailyQuoteRemoteDataSource: serviceLocator()

      )
  );

  //Data source
  serviceLocator.registerLazySingleton<DailyQuoteRemoteDataSource>(
      ()=> DailyQuoteRemoteDataSourceImpl(client: serviceLocator())
  );

  serviceLocator.registerLazySingleton<DailyQuoteLocalDataSource>(
      ()=> DailyQuoteLocalDataSourceImpl(sharedPreferences: serviceLocator())
  );

  //Core
  serviceLocator.registerLazySingleton<NetworkInfo>(
      ()=> NetworkInfoImpl(serviceLocator())
  );

  //External

  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(()=> sharedPreferences);
  serviceLocator.registerLazySingleton(()=> http.Client());
  serviceLocator.registerLazySingleton(()=>DataConnectionChecker());

}
