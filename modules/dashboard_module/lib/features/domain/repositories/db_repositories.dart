import 'package:dartz/dartz.dart';
import 'package:dashboard_module/features/domain/entities/db_get_comment_entity.dart';
import 'package:dashboard_module/features/domain/entities/db_home_feeds_entity.dart';
import 'package:dashboard_module/features/domain/entities/db_sell_confirm_entity.dart';
import 'package:share_module/core/errors/failures.dart';

abstract class DbRepository {
  Future<Either<Failure, DbHomeFeedsEntity>> getFeedData();
  Future<Either<Failure, DbGetCommentEntity>> getComments();

  Future<Either<Failure, DbSellConfirmEntity>> getSellConfirmation();
}
