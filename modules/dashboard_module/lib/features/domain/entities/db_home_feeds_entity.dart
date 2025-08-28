import 'package:equatable/equatable.dart';

class DbHomeFeedsEntity extends Equatable {
  final String status;
  final int statusCode;
  final String message;
  final List<DbHomeFeedsDataEntity> data;

  DbHomeFeedsEntity({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  @override
  List<Object?> get props => [
        status,
        statusCode,
        message,
        data,
      ];
}

class DbHomeFeedsDataEntity extends Equatable {
  final OwnerDetailsEntity ownerDetails;
  final AnimalDetailsEntity animalDetails;

  DbHomeFeedsDataEntity({
    required this.ownerDetails,
    required this.animalDetails,
  });

  @override
  List<Object?> get props => [
        ownerDetails,
        animalDetails,
      ];
}

class AnimalDetailsEntity extends Equatable {
  final String milkStatus;
  final String animalStatus;
  final String animalName;
  final String animalRate;
  final List<AnimalCollectionEntity> animalCollection;

  AnimalDetailsEntity({
    required this.milkStatus,
    required this.animalStatus,
    required this.animalName,
    required this.animalRate,
    required this.animalCollection,
  });

  @override
  List<Object?> get props => [
        milkStatus,
        animalStatus,
        animalName,
        animalRate,
        animalCollection,
      ];
}

class AnimalCollectionEntity extends Equatable {
  final String itemUrl;
  final String itemType;
  final String itemKey;
  final String itemLike;

  AnimalCollectionEntity({
    required this.itemUrl,
    required this.itemType,
    required this.itemKey,
    required this.itemLike,
  });

  @override
  List<Object?> get props => [
        itemUrl,
        itemType,
        itemKey,
        itemLike,
      ];
}

class OwnerDetailsEntity extends Equatable {
  final String ownerName;
  final String ownerMobileNumber;
  final String ownerWhatsappNumber;
  final String ownerLocation;
  final String ownerPostStatus;

  OwnerDetailsEntity({
    required this.ownerName,
    required this.ownerMobileNumber,
    required this.ownerWhatsappNumber,
    required this.ownerLocation,
    required this.ownerPostStatus,
  });

  @override
  List<Object?> get props => [
        ownerName,
        ownerMobileNumber,
        ownerWhatsappNumber,
        ownerLocation,
        ownerPostStatus,
      ];
}
