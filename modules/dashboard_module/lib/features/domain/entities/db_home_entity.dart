class DBHomeEntity {
  String status;
  int statusCode;
  String message;
  List<DBHomeDataEntity> data;

  DBHomeEntity({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });
}

class DBHomeDataEntity {
  OwnerDetails ownerDetails;
  AnimalDetails animalDetails;

  DBHomeDataEntity({
    required this.ownerDetails,
    required this.animalDetails,
  });
}

class AnimalDetails {
  String milkStatus;
  String animalStatus;
  String animalName;
  String animalRate;
  List<AnimalCollection> animalCollection;

  AnimalDetails({
    required this.milkStatus,
    required this.animalStatus,
    required this.animalName,
    required this.animalRate,
    required this.animalCollection,
  });
}

class AnimalCollection {
  String itemUrl;
  String itemType;
  String itemKey;
  String itemLike;

  AnimalCollection({
    required this.itemUrl,
    required this.itemType,
    required this.itemKey,
    required this.itemLike,
  });
}

class OwnerDetails {
  String ownerName;
  String ownerMobileNumber;
  String ownerWhatsappNumber;
  String ownerLocation;
  String ownerPostStatus;

  OwnerDetails({
    required this.ownerName,
    required this.ownerMobileNumber,
    required this.ownerWhatsappNumber,
    required this.ownerLocation,
    required this.ownerPostStatus,
  });
}
