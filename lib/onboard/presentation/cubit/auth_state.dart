import 'package:animal_app/onboard/domain/entities/ob_registration_entity.dart';
import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class ObRegInitialState extends AuthState {}

class ObRegEmptyState extends AuthState {}

class ObRegErrorState extends AuthState {
  final String errorMsg;

  const ObRegErrorState({required this.errorMsg});

  @override
  List<Object?> get props => [errorMsg];
}

class ObRegLoadingState extends AuthState {}

class ObRegLoadedState extends AuthState {
  final UserRegistrationEntity entity;

  ObRegLoadedState({required this.entity});

  @override
  List<Object?> get props => [entity];
}
