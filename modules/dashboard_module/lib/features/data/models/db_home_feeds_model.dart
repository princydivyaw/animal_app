import 'dart:convert';

import 'package:dashboard_module/features/domain/entities/db_home_feeds_entity.dart';

DbHomeFeedsModel dbHomeFeedsModelFromJson(String str) =>
    DbHomeFeedsModel.fromJson(json.decode(str));

class DbHomeFeedsModel extends DbHomeFeedsEntity {
  DbHomeFeedsModel({
    required super.status,
    required super.statusCode,
    required super.message,
    required super.data,
  });

  factory DbHomeFeedsModel.fromJson(Map<String, dynamic> json) =>
      DbHomeFeedsModel(
        status: json["status"] ?? "",
        statusCode: json["statusCode"] ?? "",
        message: json["message"] ?? "",
        data: json["data"] == []
            ? []
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );
}

class Datum extends DbHomeFeedsDataEntity {
  Datum({
    required super.ownerDetails,
    required super.animalDetails,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        ownerDetails: OwnerDetails.fromJson(json["ownerDetails"]),
        animalDetails: AnimalDetails.fromJson(json["animalDetails"]),
      );
}

class AnimalDetails extends AnimalDetailsEntity {
  AnimalDetails({
    required super.milkStatus,
    required super.animalStatus,
    required super.animalName,
    required super.animalRate,
    required super.animalCollection,
  });

  factory AnimalDetails.fromJson(Map<String, dynamic> json) => AnimalDetails(
        milkStatus: json["milkStatus"] ?? "",
        animalStatus: json["animalStatus"] ?? "",
        animalName: json["animalName"] ?? "",
        animalRate: json["animalRate"] ?? "",
        animalCollection: List<AnimalCollection>.from(
            json["animalCollection"].map((x) => AnimalCollection.fromJson(x))),
      );
}

class AnimalCollection extends AnimalCollectionEntity {
  AnimalCollection({
    required super.itemUrl,
    required super.itemType,
    required super.itemKey,
    required super.itemLike,
  });

  factory AnimalCollection.fromJson(Map<String, dynamic> json) =>
      AnimalCollection(
        itemUrl: json["itemUrl"] ?? "",
        itemType: json["itemType"] ?? "",
        itemKey: json["itemKey"] ?? "",
        itemLike: json["itemLike"] ?? "",
      );
}

class OwnerDetails extends OwnerDetailsEntity {
  OwnerDetails({
    required super.ownerName,
    required super.ownerMobileNumber,
    required super.ownerWhatsappNumber,
    required super.ownerLocation,
    required super.ownerPostStatus,
  });

  factory OwnerDetails.fromJson(Map<String, dynamic> json) => OwnerDetails(
        ownerName: json["ownerName"] ?? "",
        ownerMobileNumber: json["ownerMobileNumber"] ?? "",
        ownerWhatsappNumber: json["ownerWhatsappNumber"] ?? "",
        ownerLocation: json["ownerLocation"] ?? "",
        ownerPostStatus: json["ownerPostStatus"] ?? "",
      );
}
