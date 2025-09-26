



class CarsModel {
  final int? modelId;
  final String? modelName;
  final String? image;
  final int? manufacturerId;
  final String? manufacturer;
  final int? categoryId;
  final String? categoryName;
  final int? fuelId;
  final String? fuelType;
  final int? transmissionId;
  final String? transmission;
  final int? seater;
  final double? securityDeposit;
  final double? deliveryCharges;
  final int? availableCount;
  final bool? soldOut;
  final double? startsWith;
  final double? price;
  final int? freeKms;
  final double? additionalPerKm;
  final Plan? plan;

  CarsModel({
    this.modelId,
    this.modelName,
    this.image,
    this.manufacturerId,
    this.manufacturer,
    this.categoryId,
    this.categoryName,
    this.fuelId,
    this.fuelType,
    this.transmissionId,
    this.transmission,
    this.seater,
    this.securityDeposit,
    this.deliveryCharges,
    this.availableCount,
    this.soldOut,
    this.startsWith,
    this.price,
    this.freeKms,
    this.additionalPerKm,
    this.plan,
  });

  factory CarsModel.fromJson(Map<String, dynamic> json) {
    return CarsModel(
      modelId: _toInt(json['modelId']),
      modelName: _toString(json['modelName']),
      image: _toString(json['image']),
      manufacturerId: _toInt(json['manufacturerId']),
      manufacturer: _toString(json['manufacturer']),
      categoryId: _toInt(json['categoryId']),
      categoryName: _toString(json['categoryName']),
      fuelId: _toInt(json['fuelId']),
      fuelType: _toString(json['fuelType']),
      transmissionId: _toInt(json['transmissionId']),
      transmission: _toString(json['transmission']),
      seater: _toInt(json['seater']),
      securityDeposit: _toDouble(json['securityDeposit']),
      deliveryCharges: _toDouble(json['deliveryCharges']),
      availableCount: _toInt(json['availableCount']),
      soldOut: json['soldOut'] is bool ? json['soldOut'] as bool : _toBool(json['soldOut']),
      startsWith: _toDouble(json['startsWith']),
      price: _toDouble(json['price']),
      freeKms: _toInt(json['free_kms'] ?? json['freeKms']),
      additionalPerKm: _toDouble(json['additionalPerKm'] ?? json['additional_per_km'] ?? json['additionalPerKm']),
      plan: json['plan'] != null && json['plan'] is Map<String, dynamic>
          ? Plan.fromJson(json['plan'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'modelId': modelId,
        'modelName': modelName,
        'image': image,
        'manufacturerId': manufacturerId,
        'manufacturer': manufacturer,
        'categoryId': categoryId,
        'categoryName': categoryName,
        'fuelId': fuelId,
        'fuelType': fuelType,
        'transmissionId': transmissionId,
        'transmission': transmission,
        'seater': seater,
        'securityDeposit': securityDeposit,
        'deliveryCharges': deliveryCharges,
        'availableCount': availableCount,
        'soldOut': soldOut,
        'startsWith': startsWith,
        'price': price,
        'free_kms': freeKms,
        'additionalPerKm': additionalPerKm,
        'plan': plan?.toJson(),
      };
}

class Plan {
  final int? planId;
  final int? kmId;
  final int? isUnlimited; // backend uses 0/1; keep as int or convert to bool if you prefer
  final double? pricePerHour;
  final double? weekdayPrice;
  final double? weekendPrice;
  final double? additionalPricePerKm;
  final String? additionalChargesText;
  final double? additionalCharges;

  Plan({
    this.planId,
    this.kmId,
    this.isUnlimited,
    this.pricePerHour,
    this.weekdayPrice,
    this.weekendPrice,
    this.additionalPricePerKm,
    this.additionalChargesText,
    this.additionalCharges,
  });

  factory Plan.fromJson(Map<String, dynamic> json) {
    return Plan(
      planId: _toInt(json['planId']),
      kmId: _toInt(json['kmId']),
      isUnlimited: _toInt(json['isUnlimited']),
      pricePerHour: _toDouble(json['pricePerHour']),
      weekdayPrice: _toDouble(json['weekdayPrice']),
      weekendPrice: _toDouble(json['weekendPrice']),
      additionalPricePerKm: _toDouble(json['additionalPricePerKm']),
      additionalChargesText: _toString(json['additionalChargesText']),
      additionalCharges: _toDouble(json['additionalCharges']),
    );
  }

  Map<String, dynamic> toJson() => {
        'planId': planId,
        'kmId': kmId,
        'isUnlimited': isUnlimited,
        'pricePerHour': pricePerHour,
        'weekdayPrice': weekdayPrice,
        'weekendPrice': weekendPrice,
        'additionalPricePerKm': additionalPricePerKm,
        'additionalChargesText': additionalChargesText,
        'additionalCharges': additionalCharges,
      };
}

/// --- Helper parsing functions to be robust to null / string / numeric inputs ---
int? _toInt(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is double) return value.toInt();
  if (value is String) {
    return int.tryParse(value) ?? double.tryParse(value)?.toInt();
  }
  return null;
}

double? _toDouble(dynamic value) {
  if (value == null) return null;
  if (value is double) return value;
  if (value is int) return value.toDouble();
  if (value is String) return double.tryParse(value);
  return null;
}

String? _toString(dynamic value) {
  if (value == null) return null;
  return value.toString();
}

bool? _toBool(dynamic value) {
  if (value == null) return null;
  if (value is bool) return value;
  if (value is num) return value != 0;
  if (value is String) {
    final lower = value.toLowerCase();
    if (lower == 'true' || lower == '1') return true;
    if (lower == 'false' || lower == '0') return false;
  }
  return null;
}
