// class BookedCarmodel{
//   final String bookingId;
//   final String bookingNumber;
//   final String cityId;
//   final String? branchId;
//   final String bookingFrom;
//   final String bookingTo;
//   final String bookingSource;
//   final String customerId;
//   final String fulfillment;
//   final String? deliveryArea;
//   final String? deliveryAddress;
//   final String? deliveryContactName;
//   final String? deliveryContactMobile;
//   final String modelId;
//   final String? fleetId;
//   final String? planId;
//   final String? couponId;
//   final String? discount;
//   final String? duration;
//   final String? freeKm;
//   final String? baseFare;
//   final String? weekdayCharges;
//   final String? weekendCharges;
//   final String? subTotal;
//   final String? deliveryCharges;
//   final String? securityDeposit;
//   final String? gst;
//   final String? grandTotal;
//   final String? bookingHash;
//   final String status;
//   final String? odoMeterStart;
//   final String? odoMeterEnd;
//   final String? fuelMeterStart;
//   final String? fuelMeterEnd;
//   final String? differenceKm;
//   final String? extraKm;
//   final String? extraKmAmount;
//   final String? extraKmCharges;
//   final String? startTime;
//   final String? endTime;
//   final String? transactionId;
//   final String? startBy;
//   final String? endBy;
//   final CreatedAt? createdAt;
//   final String? modifiedAt;
//   final String? gaEventId;
//   final String? gaSent;

//   BookedCarmodel({
//     required this.bookingId,
//     required this.bookingNumber,
//     required this.cityId,
//     this.branchId,
//     required this.bookingFrom,
//     required this.bookingTo,
//     required this.bookingSource,
//     required this.customerId,
//     required this.fulfillment,
//     this.deliveryArea,
//     this.deliveryAddress,
//     this.deliveryContactName,
//     this.deliveryContactMobile,
//     required this.modelId,
//     this.fleetId,
//     this.planId,
//     this.couponId,
//     this.discount,
//     this.duration,
//     this.freeKm,
//     this.baseFare,
//     this.weekdayCharges,
//     this.weekendCharges,
//     this.subTotal,
//     this.deliveryCharges,
//     this.securityDeposit,
//     this.gst,
//     this.grandTotal,
//     this.bookingHash,
//     required this.status,
//     this.odoMeterStart,
//     this.odoMeterEnd,
//     this.fuelMeterStart,
//     this.fuelMeterEnd,
//     this.differenceKm,
//     this.extraKm,
//     this.extraKmAmount,
//     this.extraKmCharges,
//     this.startTime,
//     this.endTime,
//     this.transactionId,
//     this.startBy,
//     this.endBy,
//     this.createdAt,
//     this.modifiedAt,
//     this.gaEventId,
//     this.gaSent,
//   });

//   factory BookedCarmodel.fromJson(Map<String, dynamic> json) {
//     return BookedCarmodel(
//       bookingId: json['bookingId'] ?? '',
//       bookingNumber: json['bookingNumber'] ?? '',
//       cityId: json['cityId'] ?? '',
//       branchId: json['branchId'],
//       bookingFrom: json['bookingFrom'] ?? '',
//       bookingTo: json['bookingTo'] ?? '',
//       bookingSource: json['bookingSource'] ?? '',
//       customerId: json['customerId'] ?? '',
//       fulfillment: json['fulfillment'] ?? '',
//       deliveryArea: json['deliveryArea'],
//       deliveryAddress: json['deliveryAddress'],
//       deliveryContactName: json['deliveryContactName'],
//       deliveryContactMobile: json['deliveryContactMobile'],
//       modelId: json['modelId'] ?? '',
//       fleetId: json['fleetId'],
//       planId: json['planId'],
//       couponId: json['couponId'],
//       discount: json['discount'],
//       duration: json['duration'],
//       freeKm: json['freeKm'],
//       baseFare: json['baseFare'],
//       weekdayCharges: json['weekdayCharges'],
//       weekendCharges: json['weekendCharges'],
//       subTotal: json['subTotal'],
//       deliveryCharges: json['deliveryCharges'],
//       securityDeposit: json['securityDeposit'],
//       gst: json['gst'],
//       grandTotal: json['grandTotal'],
//       bookingHash: json['bookingHash'],
//       status: json['status'] ?? '',
//       odoMeterStart: json['odoMeterStart'],
//       odoMeterEnd: json['odoMeterEnd'],
//       fuelMeterStart: json['fuelMeterStart'],
//       fuelMeterEnd: json['fuelMeterEnd'],
//       differenceKm: json['differenceKm'],
//       extraKm: json['extraKm'],
//       extraKmAmount: json['extraKmAmount'],
//       extraKmCharges: json['extraKmCharges'],
//       startTime: json['startTime'],
//       endTime: json['endTime'],
//       transactionId: json['transactionId'],
//       startBy: json['startBy'],
//       endBy: json['endBy'],
//       createdAt: json['created_at'] != null
//           ? CreatedAt.fromJson(json['created_at'])
//           : null,
//       modifiedAt: json['modified_at'],
//       gaEventId: json['ga_event_id'],
//       gaSent: json['ga_sent'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'bookingId': bookingId,
//       'bookingNumber': bookingNumber,
//       'cityId': cityId,
//       'branchId': branchId,
//       'bookingFrom': bookingFrom,
//       'bookingTo': bookingTo,
//       'bookingSource': bookingSource,
//       'customerId': customerId,
//       'fulfillment': fulfillment,
//       'deliveryArea': deliveryArea,
//       'deliveryAddress': deliveryAddress,
//       'deliveryContactName': deliveryContactName,
//       'deliveryContactMobile': deliveryContactMobile,
//       'modelId': modelId,
//       'fleetId': fleetId,
//       'planId': planId,
//       'couponId': couponId,
//       'discount': discount,
//       'duration': duration,
//       'freeKm': freeKm,
//       'baseFare': baseFare,
//       'weekdayCharges': weekdayCharges,
//       'weekendCharges': weekendCharges,
//       'subTotal': subTotal,
//       'deliveryCharges': deliveryCharges,
//       'securityDeposit': securityDeposit,
//       'gst': gst,
//       'grandTotal': grandTotal,
//       'bookingHash': bookingHash,
//       'status': status,
//       'odoMeterStart': odoMeterStart,
//       'odoMeterEnd': odoMeterEnd,
//       'fuelMeterStart': fuelMeterStart,
//       'fuelMeterEnd': fuelMeterEnd,
//       'differenceKm': differenceKm,
//       'extraKm': extraKm,
//       'extraKmAmount': extraKmAmount,
//       'extraKmCharges': extraKmCharges,
//       'startTime': startTime,
//       'endTime': endTime,
//       'transactionId': transactionId,
//       'startBy': startBy,
//       'endBy': endBy,
//       'created_at': createdAt?.toJson(),
//       'modified_at': modifiedAt,
//       'ga_event_id': gaEventId,
//       'ga_sent': gaSent,
//     };
//   }
// }

// class CreatedAt {
//   final String date;
//   final int timezoneType;
//   final String timezone;

//   CreatedAt({
//     required this.date,
//     required this.timezoneType,
//     required this.timezone,
//   });

//   factory CreatedAt.fromJson(Map<String, dynamic> json) {
//     return CreatedAt(
//       date: json['date'] ?? '',
//       timezoneType: json['timezone_type'] ?? 0,
//       timezone: json['timezone'] ?? '',
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'date': date,
//       'timezone_type': timezoneType,
//       'timezone': timezone,
//     };
//   }
// }
////////////////////////////////////
class BookedCarmodel {
  final String bookingId;
  final String bookingNumber;
  final String cityId;
  final String? branchId;
  final String bookingFrom;
  final String bookingTo;
  final String bookingSource;
  final String customerId;
  final String fulfillment;
  final String? deliveryArea;
  final String? deliveryAddress;
  final String? deliveryContactName;
  final String? deliveryContactMobile;
  final String modelId;
  final String? fleetId;
  final String? planId;
  final String? couponId;
  final String? discount;
  final String? duration;
  final String? freeKm;
  final String? baseFare;
  final String? weekdayCharges;
  final String? weekendCharges;
  final String? subTotal;
  final String? deliveryCharges;
  final String? securityDeposit;
  final String? gst;
  final String? grandTotal;
  final String? bookingHash;
  final String status;
  final String? odoMeterStart;
  final String? odoMeterEnd;
  final String? fuelMeterStart;
  final String? fuelMeterEnd;
  final String? differenceKm;
  final String? extraKm;
  final String? extraKmAmount;
  final String? extraKmCharges;
  final String? startTime;
  final String? endTime;
  final String? transactionId;
  final String? startBy;
  final String? endBy;
  final CreatedAt? createdAt;
  final String? modifiedAt;
  final String? gaEventId;
  final String? gaSent;

  // new nested objects
  final KmDetails? kmDetails;
  final ModelDetails? modelDetails;

  BookedCarmodel({
    required this.bookingId,
    required this.bookingNumber,
    required this.cityId,
    this.branchId,
    required this.bookingFrom,
    required this.bookingTo,
    required this.bookingSource,
    required this.customerId,
    required this.fulfillment,
    this.deliveryArea,
    this.deliveryAddress,
    this.deliveryContactName,
    this.deliveryContactMobile,
    required this.modelId,
    this.fleetId,
    this.planId,
    this.couponId,
    this.discount,
    this.duration,
    this.freeKm,
    this.baseFare,
    this.weekdayCharges,
    this.weekendCharges,
    this.subTotal,
    this.deliveryCharges,
    this.securityDeposit,
    this.gst,
    this.grandTotal,
    this.bookingHash,
    required this.status,
    this.odoMeterStart,
    this.odoMeterEnd,
    this.fuelMeterStart,
    this.fuelMeterEnd,
    this.differenceKm,
    this.extraKm,
    this.extraKmAmount,
    this.extraKmCharges,
    this.startTime,
    this.endTime,
    this.transactionId,
    this.startBy,
    this.endBy,
    this.createdAt,
    this.modifiedAt,
    this.gaEventId,
    this.gaSent,
    this.kmDetails,
    this.modelDetails,
  });

  factory BookedCarmodel.fromJson(Map<String, dynamic> json) {
    return BookedCarmodel(
      bookingId: json['bookingId']?.toString() ?? '',
      bookingNumber: json['bookingNumber']?.toString() ?? '',
      cityId: json['cityId']?.toString() ?? '',
      branchId: json['branchId']?.toString(),
      bookingFrom: json['bookingFrom']?.toString() ?? '',
      bookingTo: json['bookingTo']?.toString() ?? '',
      bookingSource: json['bookingSource']?.toString() ?? '',
      customerId: json['customerId']?.toString() ?? '',
      fulfillment: json['fulfillment']?.toString() ?? '',
      deliveryArea: json['deliveryArea']?.toString(),
      deliveryAddress: json['deliveryAddress']?.toString(),
      deliveryContactName: json['deliveryContactName']?.toString(),
      deliveryContactMobile: json['deliveryContactMobile']?.toString(),
      modelId: json['modelId']?.toString() ?? '',
      fleetId: json['fleetId']?.toString(),
      planId: json['planId']?.toString(),
      couponId: json['couponId']?.toString(),
      discount: json['discount']?.toString(),
      duration: json['duration']?.toString(),
      freeKm: json['freeKm']?.toString(),
      baseFare: json['baseFare']?.toString(),
      weekdayCharges: json['weekdayCharges']?.toString(),
      weekendCharges: json['weekendCharges']?.toString(),
      subTotal: json['subTotal']?.toString(),
      deliveryCharges: json['deliveryCharges']?.toString(),
      securityDeposit: json['securityDeposit']?.toString(),
      gst: json['gst']?.toString(),
      grandTotal: json['grandTotal']?.toString(),
      bookingHash: json['bookingHash']?.toString(),
      status: json['status']?.toString() ?? '',
      odoMeterStart: json['odoMeterStart']?.toString(),
      odoMeterEnd: json['odoMeterEnd']?.toString(),
      fuelMeterStart: json['fuelMeterStart']?.toString(),
      fuelMeterEnd: json['fuelMeterEnd']?.toString(),
      differenceKm: json['differenceKm']?.toString(),
      extraKm: json['extraKm']?.toString(),
      extraKmAmount: json['extraKmAmount']?.toString(),
      extraKmCharges: json['extraKmCharges']?.toString(),
      startTime: json['startTime']?.toString(),
      endTime: json['endTime']?.toString(),
      transactionId: json['transactionId']?.toString(),
      startBy: json['startBy']?.toString(),
      endBy: json['endBy']?.toString(),
      createdAt: json['created_at'] != null
          ? CreatedAt.fromJson(Map<String, dynamic>.from(json['created_at']))
          : null,
      modifiedAt: json['modified_at']?.toString(),
      gaEventId: json['ga_event_id']?.toString(),
      gaSent: json['ga_sent']?.toString(),
      kmDetails: json['kmDetails'] != null
          ? KmDetails.fromJson(Map<String, dynamic>.from(json['kmDetails']))
          : null,
      modelDetails: json['modelDetails'] != null
          ? ModelDetails.fromJson(Map<String, dynamic>.from(json['modelDetails']))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bookingId': bookingId,
      'bookingNumber': bookingNumber,
      'cityId': cityId,
      'branchId': branchId,
      'bookingFrom': bookingFrom,
      'bookingTo': bookingTo,
      'bookingSource': bookingSource,
      'customerId': customerId,
      'fulfillment': fulfillment,
      'deliveryArea': deliveryArea,
      'deliveryAddress': deliveryAddress,
      'deliveryContactName': deliveryContactName,
      'deliveryContactMobile': deliveryContactMobile,
      'modelId': modelId,
      'fleetId': fleetId,
      'planId': planId,
      'couponId': couponId,
      'discount': discount,
      'duration': duration,
      'freeKm': freeKm,
      'baseFare': baseFare,
      'weekdayCharges': weekdayCharges,
      'weekendCharges': weekendCharges,
      'subTotal': subTotal,
      'deliveryCharges': deliveryCharges,
      'securityDeposit': securityDeposit,
      'gst': gst,
      'grandTotal': grandTotal,
      'bookingHash': bookingHash,
      'status': status,
      'odoMeterStart': odoMeterStart,
      'odoMeterEnd': odoMeterEnd,
      'fuelMeterStart': fuelMeterStart,
      'fuelMeterEnd': fuelMeterEnd,
      'differenceKm': differenceKm,
      'extraKm': extraKm,
      'extraKmAmount': extraKmAmount,
      'extraKmCharges': extraKmCharges,
      'startTime': startTime,
      'endTime': endTime,
      'transactionId': transactionId,
      'startBy': startBy,
      'endBy': endBy,
      'created_at': createdAt?.toJson(),
      'modified_at': modifiedAt,
      'ga_event_id': gaEventId,
      'ga_sent': gaSent,
      'kmDetails': kmDetails?.toJson(),
      'modelDetails': modelDetails?.toJson(),
    };
  }
}

class CreatedAt {
  final String date;
  final int timezoneType;
  final String timezone;

  CreatedAt({
    required this.date,
    required this.timezoneType,
    required this.timezone,
  });

  factory CreatedAt.fromJson(Map<String, dynamic> json) {
    return CreatedAt(
      date: json['date']?.toString() ?? '',
      timezoneType: (json['timezone_type'] is int)
          ? json['timezone_type']
          : int.tryParse(json['timezone_type']?.toString() ?? '') ?? 0,
      timezone: json['timezone']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'timezone_type': timezoneType,
      'timezone': timezone,
    };
  }
}

class KmDetails {
  final String kmId;
  final String kmLimit;
  final String status;
  final CreatedAt? createdAt;
  final String? modifiedAt;

  KmDetails({
    required this.kmId,
    required this.kmLimit,
    required this.status,
    this.createdAt,
    this.modifiedAt,
  });

  factory KmDetails.fromJson(Map<String, dynamic> json) {
    return KmDetails(
      kmId: json['kmId']?.toString() ?? '',
      kmLimit: json['kmLimit']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      createdAt: json['created_at'] != null
          ? CreatedAt.fromJson(Map<String, dynamic>.from(json['created_at']))
          : null,
      modifiedAt: json['modified_at']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'kmId': kmId,
      'kmLimit': kmLimit,
      'status': status,
      'created_at': createdAt?.toJson(),
      'modified_at': modifiedAt,
    };
  }
}

class ModelDetails {
  final String modelId;
  final String? fleetTypeId;
  final String? manufacturerId;
  final String? modelName;
  final String? categoryId;
  final String? fuelId;
  final String? transmissionId;
  final String? tankCapacity;
  final String? airCondition;
  final String? parkingCamera;
  final String? ncapRating;
  final String? seater;
  final String? mileage;
  final String? luggageCarrier;
  final String? varient;
  final String? securityDeposit;
  final String? deliveryCharges;
  final String? description;
  final String? image;
  final String? status;
  final String? modelHash;
  final CreatedAt? createdAt;
  final String? modifiedAt;

  ModelDetails({
    required this.modelId,
    this.fleetTypeId,
    this.manufacturerId,
    this.modelName,
    this.categoryId,
    this.fuelId,
    this.transmissionId,
    this.tankCapacity,
    this.airCondition,
    this.parkingCamera,
    this.ncapRating,
    this.seater,
    this.mileage,
    this.luggageCarrier,
    this.varient,
    this.securityDeposit,
    this.deliveryCharges,
    this.description,
    this.image,
    this.status,
    this.modelHash,
    this.createdAt,
    this.modifiedAt,
  });

  factory ModelDetails.fromJson(Map<String, dynamic> json) {
    return ModelDetails(
      modelId: json['modelId']?.toString() ?? '',
      fleetTypeId: json['fleetTypeId']?.toString(),
      manufacturerId: json['manufacturerId']?.toString(),
      modelName: json['modelName']?.toString(),
      categoryId: json['categoryId']?.toString(),
      fuelId: json['fuelId']?.toString(),
      transmissionId: json['transmissionId']?.toString(),
      tankCapacity: json['tankCapacity']?.toString(),
      airCondition: json['airCondition']?.toString(),
      parkingCamera: json['parkingCamera']?.toString(),
      ncapRating: json['ncapRating']?.toString(),
      seater: json['seater']?.toString(),
      mileage: json['mileage']?.toString(),
      luggageCarrier: json['luggageCarrier']?.toString(),
      varient: json['varient']?.toString(),
      securityDeposit: json['securityDeposit']?.toString(),
      deliveryCharges: json['deliveryCharges']?.toString(),
      description: json['description']?.toString(),
      image: json['image']?.toString(),
      status: json['status']?.toString(),
      modelHash: json['modelHash']?.toString(),
      createdAt: json['created_at'] != null
          ? CreatedAt.fromJson(Map<String, dynamic>.from(json['created_at']))
          : null,
      modifiedAt: json['modified_at']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'modelId': modelId,
      'fleetTypeId': fleetTypeId,
      'manufacturerId': manufacturerId,
      'modelName': modelName,
      'categoryId': categoryId,
      'fuelId': fuelId,
      'transmissionId': transmissionId,
      'tankCapacity': tankCapacity,
      'airCondition': airCondition,
      'parkingCamera': parkingCamera,
      'ncapRating': ncapRating,
      'seater': seater,
      'mileage': mileage,
      'luggageCarrier': luggageCarrier,
      'varient': varient,
      'securityDeposit': securityDeposit,
      'deliveryCharges': deliveryCharges,
      'description': description,
      'image': image,
      'status': status,
      'modelHash': modelHash,
      'created_at': createdAt?.toJson(),
      'modified_at': modifiedAt,
    };
  }
}
