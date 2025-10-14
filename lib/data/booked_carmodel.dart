class BookedCarmodel{
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
  });

  factory BookedCarmodel.fromJson(Map<String, dynamic> json) {
    return BookedCarmodel(
      bookingId: json['bookingId'] ?? '',
      bookingNumber: json['bookingNumber'] ?? '',
      cityId: json['cityId'] ?? '',
      branchId: json['branchId'],
      bookingFrom: json['bookingFrom'] ?? '',
      bookingTo: json['bookingTo'] ?? '',
      bookingSource: json['bookingSource'] ?? '',
      customerId: json['customerId'] ?? '',
      fulfillment: json['fulfillment'] ?? '',
      deliveryArea: json['deliveryArea'],
      deliveryAddress: json['deliveryAddress'],
      deliveryContactName: json['deliveryContactName'],
      deliveryContactMobile: json['deliveryContactMobile'],
      modelId: json['modelId'] ?? '',
      fleetId: json['fleetId'],
      planId: json['planId'],
      couponId: json['couponId'],
      discount: json['discount'],
      duration: json['duration'],
      freeKm: json['freeKm'],
      baseFare: json['baseFare'],
      weekdayCharges: json['weekdayCharges'],
      weekendCharges: json['weekendCharges'],
      subTotal: json['subTotal'],
      deliveryCharges: json['deliveryCharges'],
      securityDeposit: json['securityDeposit'],
      gst: json['gst'],
      grandTotal: json['grandTotal'],
      bookingHash: json['bookingHash'],
      status: json['status'] ?? '',
      odoMeterStart: json['odoMeterStart'],
      odoMeterEnd: json['odoMeterEnd'],
      fuelMeterStart: json['fuelMeterStart'],
      fuelMeterEnd: json['fuelMeterEnd'],
      differenceKm: json['differenceKm'],
      extraKm: json['extraKm'],
      extraKmAmount: json['extraKmAmount'],
      extraKmCharges: json['extraKmCharges'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      transactionId: json['transactionId'],
      startBy: json['startBy'],
      endBy: json['endBy'],
      createdAt: json['created_at'] != null
          ? CreatedAt.fromJson(json['created_at'])
          : null,
      modifiedAt: json['modified_at'],
      gaEventId: json['ga_event_id'],
      gaSent: json['ga_sent'],
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
      date: json['date'] ?? '',
      timezoneType: json['timezone_type'] ?? 0,
      timezone: json['timezone'] ?? '',
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
