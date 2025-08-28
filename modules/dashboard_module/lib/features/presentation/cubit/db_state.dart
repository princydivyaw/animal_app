import 'package:dashboard_module/features/domain/entities/db_get_comment_entity.dart';
import 'package:dashboard_module/features/domain/entities/db_home_feeds_entity.dart';
import 'package:equatable/equatable.dart';

abstract class DBState extends Equatable {
  const DBState();

  @override
  List<Object?> get props => [];
}

class GetFeedDataInitialState extends DBState {}

class GetFeedDataEmptyState extends DBState {}

class GetFeedDataErrorState extends DBState {
  final String errorMsg;

  const GetFeedDataErrorState({required this.errorMsg});

  @override
  List<Object?> get props => [errorMsg];
}

class GetFeedDataLoadingState extends DBState {}

class GetFeedDataLoadedState extends DBState {
  final DbHomeFeedsEntity feedEntity;

  const GetFeedDataLoadedState({required this.feedEntity});

  @override
  List<Object?> get props => [feedEntity];
}

class GetCommentInitialState extends DBState {}

class GetCommentEmptyState extends DBState {}

class GetCommentErrorState extends DBState {
  final String errorMsg;

  const GetCommentErrorState({required this.errorMsg});

  @override
  List<Object?> get props => [errorMsg];
}

class GetCommentLoadingState extends DBState {}

class GetCommentLoadedState extends DBState {
  final DbGetCommentEntity entity;

  const GetCommentLoadedState({required this.entity});

  @override
  List<Object?> get props => [entity];
}
