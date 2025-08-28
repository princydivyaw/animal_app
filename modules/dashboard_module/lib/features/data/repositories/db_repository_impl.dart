import 'package:dartz/dartz.dart';
import 'package:dashboard_module/features/data/datasources/db_datasources.dart';
import 'package:dashboard_module/features/domain/entities/db_get_comment_entity.dart';
import 'package:dashboard_module/features/domain/entities/db_home_feeds_entity.dart';
import 'package:dashboard_module/features/domain/entities/db_sell_confirm_entity.dart';
import 'package:dashboard_module/features/domain/repositories/db_repositories.dart';
import 'package:share_module/core/errors/failures.dart';

class DbRepositoryImpl implements DbRepository {
  final DbDataSource dbDataSource;

  DbRepositoryImpl({required this.dbDataSource});

  @override
  Future<Either<Failure, DbHomeFeedsEntity>> getFeedData() async {
    try {
      final value = await dbDataSource.getFeedData();
      if (value is DbHomeFeedsEntity) {
        return Right(value);
      } else {
        return Left(UnknownFailure(message: value.toString()));
      }
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, DbGetCommentEntity>> getComments() async {
    try {
      final value = await dbDataSource.getComments();
      if (value is DbGetCommentEntity) {
        return Right(value);
      } else {
        return Left(UnknownFailure(message: value.toString()));
      }
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, DbSellConfirmEntity>> getSellConfirmation() async {
    try {
      final value = await dbDataSource.getSellConfirmation();
      if (value is DbSellConfirmEntity) {
        return Right(value);
      } else {
        return Left(UnknownFailure(message: value.toString()));
      }
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}
