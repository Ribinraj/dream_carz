class BookingOverviewModel{
  final DateTime? bookingFrom;
  final DateTime? bookingTo;
  final int? kmId;
  final int? kmLimit;
  final int? minimumHours;
  final int? cityId;
  final CardInfo? card;
  final PriceData? priceData;
  final List<Branch> availableBranches;
  final List<City> cities;

  BookingOverviewModel({
    this.bookingFrom,
    this.bookingTo,
    this.kmId,
    this.kmLimit,
    this.minimumHours,
    this.cityId,
    this.card,
    this.priceData,
    List<Branch>? availableBranches,
    List<City>? cities,
  })  : availableBranches = availableBranches ?? [],
        cities = cities ?? [];

  factory BookingOverviewModel.fromJson(Map<String, dynamic> json) {
    return BookingOverviewModel(
      bookingFrom: _asDateTime(json['bookingFrom']),
      bookingTo: _asDateTime(json['bookingTo']),
      kmId: _asInt(json['kmId']),
      kmLimit: _asInt(json['kmLimit']),
      minimumHours: _asInt(json['minimumHours']),
      cityId: _asInt(json['cityId']),
      card: json['card'] == null ? null : CardInfo.fromJson(json['card'] as Map<String, dynamic>),
      priceData: json['priceData'] == null ? null : PriceData.fromJson(json['priceData'] as Map<String, dynamic>),
      availableBranches: (json['availableBranches'] as List<dynamic>?)
              ?.map((e) => Branch.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      cities: (json['cities'] as List<dynamic>?)
              ?.map((e) => City.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
        'bookingFrom': bookingFrom?.toIso8601String(),
        'bookingTo': bookingTo?.toIso8601String(),
        'kmId': kmId,
        'kmLimit': kmLimit,
        'minimumHours': minimumHours,
        'cityId': cityId,
        'card': card?.toJson(),
        'priceData': priceData?.toJson(),
        'availableBranches': availableBranches.map((b) => b.toJson()).toList(),
        'cities': cities.map((c) => c.toJson()).toList(),
      };
}

/* ===========================
   CardInfo (car details)
   =========================== */
class CardInfo {
  final int? modelId;
  final String? modelName;
  final String? image;
  final String? manufacturer;
  final String? categoryName;
  final String? fuelType;
  final String? transmission;
  final int? seater;
  final double? securityDeposit;
  final double? deliveryCharges;
  final double? startsWith;
  final double? price;
  final int? freeKms;
  final double? additionalPerKm;
  final Plan? plan;

  CardInfo({
    this.modelId,
    this.modelName,
    this.image,
    this.manufacturer,
    this.categoryName,
    this.fuelType,
    this.transmission,
    this.seater,
    this.securityDeposit,
    this.deliveryCharges,
    this.startsWith,
    this.price,
    this.freeKms,
    this.additionalPerKm,
    this.plan,
  });

  factory CardInfo.fromJson(Map<String, dynamic> json) {
    return CardInfo(
      modelId: _asInt(json['modelId']),
      modelName: _asString(json['modelName']),
      image: _asString(json['image']),
      manufacturer: _asString(json['manufacturer']),
      categoryName: _asString(json['categoryName']),
      fuelType: _asString(json['fuelType']),
      transmission: _asString(json['transmission']),
      seater: _asInt(json['seater']),
      securityDeposit: _asDouble(json['securityDeposit']),
      deliveryCharges: _asDouble(json['deliveryCharges']),
      startsWith: _asDouble(json['startsWith']),
      price: _asDouble(json['price']),
      freeKms: _asInt(json['free_kms'] ?? json['free_kms'] ?? json['free_kms']), // tolerate variants
      additionalPerKm: _asDouble(json['additionalPerKm'] ?? json['additionalPerKm'] ?? json['additionalPerKm']),
      plan: json['plan'] == null ? null : Plan.fromJson(json['plan'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'modelId': modelId,
        'modelName': modelName,
        'image': image,
        'manufacturer': manufacturer,
        'categoryName': categoryName,
        'fuelType': fuelType,
        'transmission': transmission,
        'seater': seater,
        'securityDeposit': securityDeposit,
        'deliveryCharges': deliveryCharges,
        'startsWith': startsWith,
        'price': price,
        'free_kms': freeKms,
        'additionalPerKm': additionalPerKm,
        'plan': plan?.toJson(),
      };
}

/* ===========================
   Plan
   =========================== */
class Plan {
  final int? planId;
  final int? kmId;
  final bool? isUnlimited;
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
      planId: _asInt(json['planId']),
      kmId: _asInt(json['kmId']),
      isUnlimited: _asInt(json['isUnlimited']) == 1,
      pricePerHour: _asDouble(json['pricePerHour']),
      weekdayPrice: _asDouble(json['weekdayPrice']),
      weekendPrice: _asDouble(json['weekendPrice']),
      additionalPricePerKm: _asDouble(json['additionalPricePerKm']),
      additionalChargesText: _asString(json['additionalChargesText']),
      additionalCharges: _asDouble(json['additionalCharges']),
    );
  }

  Map<String, dynamic> toJson() => {
        'planId': planId,
        'kmId': kmId,
        'isUnlimited': (isUnlimited ?? false) ? 1 : 0,
        'pricePerHour': pricePerHour,
        'weekdayPrice': weekdayPrice,
        'weekendPrice': weekendPrice,
        'additionalPricePerKm': additionalPricePerKm,
        'additionalChargesText': additionalChargesText,
        'additionalCharges': additionalCharges,
      };
}

/* ===========================
   PriceData
   =========================== */
class PriceData {
  final String? modelName;
  final double? price;
  final int? freeKms;
  final int? totalHours;
  final int? weekdayHours;
  final int? weekendHours;
  final bool? isPeak;
  final double? additionalPricePerKm;
  final double? weekdayCharges;
  final double? weekendCharges;
  final double? baseFare;
  final double? deliveryCharges;
  final double? securityDeposit;
  final String? kmId; // server sends string "1"

  PriceData({
    this.modelName,
    this.price,
    this.freeKms,
    this.totalHours,
    this.weekdayHours,
    this.weekendHours,
    this.isPeak,
    this.additionalPricePerKm,
    this.weekdayCharges,
    this.weekendCharges,
    this.baseFare,
    this.deliveryCharges,
    this.securityDeposit,
    this.kmId,
  });

  factory PriceData.fromJson(Map<String, dynamic> json) {
    return PriceData(
      modelName: _asString(json['modelName']),
      price: _asDouble(json['price']),
      freeKms: _asInt(json['free_kms']),
      totalHours: _asInt(json['total_hours']),
      weekdayHours: _asInt(json['weekday_hours']),
      weekendHours: _asInt(json['weekend_hours']),
      isPeak: _asBool(json['is_peak']),
      additionalPricePerKm: _asDouble(json['additionalPricePerKm']),
      weekdayCharges: _asDouble(json['weekdayCharges']),
      weekendCharges: _asDouble(json['weekendCharges']),
      baseFare: _asDouble(json['baseFare']),
      deliveryCharges: _asDouble(json['deliveryCharges']),
      securityDeposit: _asDouble(json['securityDeposit']),
      kmId: _asString(json['kmId']),
    );
  }

  Map<String, dynamic> toJson() => {
        'modelName': modelName,
        'price': price,
        'free_kms': freeKms,
        'total_hours': totalHours,
        'weekday_hours': weekdayHours,
        'weekend_hours': weekendHours,
        'is_peak': isPeak,
        'additionalPricePerKm': additionalPricePerKm,
        'weekdayCharges': weekdayCharges,
        'weekendCharges': weekendCharges,
        'baseFare': baseFare,
        'deliveryCharges': deliveryCharges,
        'securityDeposit': securityDeposit,
        'kmId': kmId,
      };
}

/* ===========================
   Branch
   =========================== */
class Branch {
  final String? branchId;
  final String? name;
  final String? address;
  final String? contactNumber;
  final String? whatsappNumber;
  final String? contactEmail;
  final String? cityId;
  final String? status;
  final DateTime? createdAt;
  final String? modifiedAt;

  Branch({
    this.branchId,
    this.name,
    this.address,
    this.contactNumber,
    this.whatsappNumber,
    this.contactEmail,
    this.cityId,
    this.status,
    this.createdAt,
    this.modifiedAt,
  });

  factory Branch.fromJson(Map<String, dynamic> json) {
    final created = json['created_at'];
    DateTime? createdAt;
    if (created is Map<String, dynamic>) {
      createdAt = _asDateTime(created['date']);
    } else {
      createdAt = _asDateTime(json['created_at']);
    }

    return Branch(
      branchId: _asString(json['branchId']),
      name: _asString(json['name']),
      address: _asString(json['address']),
      contactNumber: _asString(json['contactNumber']),
      whatsappNumber: _asString(json['whatsappNumber']),
      contactEmail: _asString(json['contactEmail']),
      cityId: _asString(json['cityId']),
      status: _asString(json['status']),
      createdAt: createdAt,
      modifiedAt: _asString(json['modified_at']),
    );
  }

  Map<String, dynamic> toJson() => {
        'branchId': branchId,
        'name': name,
        'address': address,
        'contactNumber': contactNumber,
        'whatsappNumber': whatsappNumber,
        'contactEmail': contactEmail,
        'cityId': cityId,
        'status': status,
        'created_at': createdAt?.toIso8601String(),
        'modified_at': modifiedAt,
      };
}

/* ===========================
   City
   =========================== */
class City {
  final String? cityId;
  final String? name;
  final String? status;
  final DateTime? createdAt;
  final String? modifiedAt;

  City({this.cityId, this.name, this.status, this.createdAt, this.modifiedAt});

  factory City.fromJson(Map<String, dynamic> json) {
    final created = json['created_at'];
    DateTime? createdAt;
    if (created is Map<String, dynamic>) {
      createdAt = _asDateTime(created['date']);
    } else {
      createdAt = _asDateTime(json['created_at']);
    }

    return City(
      cityId: _asString(json['cityId']),
      name: _asString(json['name']),
      status: _asString(json['status']),
      createdAt: createdAt,
      modifiedAt: _asString(json['modified_at']),
    );
  }

  Map<String, dynamic> toJson() => {
        'cityId': cityId,
        'name': name,
        'status': status,
        'created_at': createdAt?.toIso8601String(),
        'modified_at': modifiedAt,
      };
}

/* ===========================
   Helper conversion functions
   =========================== */

int? _asInt(dynamic v) {
  if (v == null) return null;
  if (v is int) return v;
  if (v is double) return v.toInt();
  if (v is String) {
    return int.tryParse(v) ?? double.tryParse(v)?.toInt();
  }
  return null;
}

double? _asDouble(dynamic v) {
  if (v == null) return null;
  if (v is double) return v;
  if (v is int) return v.toDouble();
  if (v is String) return double.tryParse(v);
  return null;
}

String? _asString(dynamic v) {
  if (v == null) return null;
  if (v is String) return v;
  return v.toString();
}

bool? _asBool(dynamic v) {
  if (v == null) return null;
  if (v is bool) return v;
  if (v is int) return v == 1;
  if (v is String) {
    final lower = v.toLowerCase();
    if (lower == 'true' || lower == '1') return true;
    if (lower == 'false' || lower == '0') return false;
  }
  return null;
}

DateTime? _asDateTime(dynamic v) {
  if (v == null) return null;
  if (v is DateTime) return v;
  if (v is String) {
    // Try parsing common formats
    try {
      return DateTime.parse(v);
    } catch (_) {
      // try replacing space with T if server sends "2025-10-06 10:00:00"
      try {
        return DateTime.parse(v.replaceFirst(' ', 'T'));
      } catch (_) {
        return null;
      }
    }
  }
  return null;
}
