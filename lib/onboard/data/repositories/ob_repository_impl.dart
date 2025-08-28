import 'package:animal_app/onboard/data/datasources/ob_datasources.dart';
import 'package:animal_app/onboard/data/models/ob_all_request_model.dart';
import 'package:animal_app/onboard/domain/entities/ob_registration_entity.dart';
import 'package:animal_app/onboard/domain/repositories/ob_repositories.dart';
import 'package:dartz/dartz.dart';
import 'package:share_module/core/errors/failures.dart';

class ObRepositoryImpl implements ObRepository {
  final ObDataSource obDataSource;

  ObRepositoryImpl({required this.obDataSource});

  @override
  Future<Either<Failure, UserRegistrationEntity>> register({
    required ObRegRequestModel request,
  }) async {
    try {
      final value = await obDataSource.register(request: request);
      if (value is UserRegistrationEntity) {
        return Right(value);
      } else {
        return Left(UnknownFailure(message: value.toString()));
      }
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}
