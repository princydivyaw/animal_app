import 'package:dartz/dartz.dart';
import 'package:dashboard_module/features/domain/entities/db_get_comment_entity.dart';
import 'package:dashboard_module/features/domain/entities/db_home_feeds_entity.dart';
import 'package:dashboard_module/features/domain/entities/db_sell_confirm_entity.dart';
import 'package:dashboard_module/features/domain/repositories/db_repositories.dart';
import 'package:share_module/core/errors/failures.dart';

class DbUseCase {
  final DbRepository dbRepository;

  DbUseCase({required this.dbRepository});

  Future<Either<Failure, DbHomeFeedsEntity>> getFeedData() {
    return dbRepository.getFeedData();
  }

  Future<Either<Failure, DbGetCommentEntity>> getComments() {
    return dbRepository.getComments();
  }

  Future<Either<Failure, DbSellConfirmEntity>> getSellConfirmation() {
    return dbRepository.getSellConfirmation();
  }
}
