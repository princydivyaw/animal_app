import 'package:dashboard_module/features/domain/entities/db_sell_confirm_entity.dart';
import 'package:equatable/equatable.dart';

abstract class DBSellConfirmState extends Equatable {
  const DBSellConfirmState();

  @override
  List<Object?> get props => [];
}

class SellConfirmInitialState extends DBSellConfirmState {}

class SellConfirmEmptyState extends DBSellConfirmState {}

class SellConfirmErrorState extends DBSellConfirmState {
  final String errorMsg;

  const SellConfirmErrorState({required this.errorMsg});

  @override
  List<Object?> get props => [errorMsg];
}

class SellConfirmLoadingState extends DBSellConfirmState {}

class SellConfirmLoadedState extends DBSellConfirmState {
  final DbSellConfirmEntity entity;

  const SellConfirmLoadedState({required this.entity});

  @override
  List<Object?> get props => [entity];
}
