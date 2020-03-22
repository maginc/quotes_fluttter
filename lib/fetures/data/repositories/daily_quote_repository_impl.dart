import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:quotesfluttter/core/error/exceptions.dart';
import 'package:quotesfluttter/core/error/failures.dart';
import 'package:quotesfluttter/core/platform/network_info.dart';
import 'package:quotesfluttter/fetures/data/datasource/daily_quote_local_data_source.dart';
import 'package:quotesfluttter/fetures/data/datasource/daily_quote_remote_data_source.dart';
import 'package:quotesfluttter/fetures/data/model/daily_quote.dart';
import 'package:quotesfluttter/fetures/domain/repositorie/daily_quote_repository.dart';

class DailyQuoteRepositoryImpl implements DailyQuoteRepository{
  final DailyQuoteRemoteDataSource dailyQuoteRemoteDataSource;
  final DailyQuoteLocalDataSource dailyQuoteLocalDataSource;
  final NetworkInfo networkInfo;

  DailyQuoteRepositoryImpl({
      @required this.dailyQuoteRemoteDataSource,
      @required this.dailyQuoteLocalDataSource,
      @required this.networkInfo
  });

  @override
  Future<Either<Failure, DailyQuote>> getDailyQuote() async {
    return await _getQuote();
  }

  Future<Either<Failure, DailyQuote>> _getQuote() async {

    if(await networkInfo.isConnected){
      try {
        final remoteQuote = await dailyQuoteRemoteDataSource.getDailyQuote();
        dailyQuoteLocalDataSource.cacheDailyQuote(remoteQuote);
        return Right(remoteQuote);
      } on ServerException{
        return Left(ServerFailure());
      }
    } else {
      try {
        return Right(await dailyQuoteLocalDataSource.getLastDailyQuote());
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}