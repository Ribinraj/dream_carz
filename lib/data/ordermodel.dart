
class Ordermodel {
  Ordermodel({
    this.bookingId,
    this.bookingNumber,
    this.cityId,
    this.branchId,
    this.bookingFrom,
    this.bookingTo,
    this.bookingSource,
    this.customerId,
    this.fulfillment,
    this.deliveryArea,
    this.deliveryAddress,
    this.deliveryContactName,
    this.deliveryContactMobile,
    this.modelId,
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
    this.status,
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
    this.cityName,
    this.branch,
    this.model,
    this.fleet,
    this.payments,
    this.documents,
  });

  final String? bookingId;
  final String? bookingNumber;
  final String? cityId;
  final String? branchId;
  final DateTime? bookingFrom; // parsed
  final DateTime? bookingTo; // parsed
  final String? bookingSource;
  final String? customerId;
  final String? fulfillment;
  final String? deliveryArea;
  final String? deliveryAddress;
  final String? deliveryContactName;
  final String? deliveryContactMobile;
  final String? modelId;
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
  final String? status;
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
  final Timestamp? createdAt;
  final String? modifiedAt;
  final String? gaEventId;
  final String? gaSent;
  final String? cityName;
  final Branch? branch;
  final Model? model;
  final dynamic fleet; // unknown shape in sample, keep dynamic
  final List<Payment>? payments;
  final List<BookingDocument>? documents;

  /// Helper getters to access timestamps as DateTime
  DateTime? get createdAtDateTime => createdAt?.dateTime;

  factory Ordermodel.fromJson(Map<String, dynamic> json) {
    DateTime? parseDate(String? s) {
      if (s == null) return null;
      // try parse directly; input format: "2025-10-18 15:30:00"
      try {
        // replace space with 'T' to make it ISO-like for DateTime.parse
        final cleaned = s.replaceFirst(' ', 'T');
        return DateTime.tryParse(cleaned);
      } catch (_) {
        return null;
      }
    }

    return Ordermodel(
      bookingId: json['bookingId']?.toString(),
      bookingNumber: json['bookingNumber']?.toString(),
      cityId: json['cityId']?.toString(),
      branchId: json['branchId']?.toString(),
      bookingFrom: parseDate(json['bookingFrom'] as String?),
      bookingTo: parseDate(json['bookingTo'] as String?),
      bookingSource: json['bookingSource'] as String?,
      customerId: json['customerId']?.toString(),
      fulfillment: json['fulfillment'] as String?,
      deliveryArea: json['deliveryArea'] as String?,
      deliveryAddress: json['deliveryAddress'] as String?,
      deliveryContactName: json['deliveryContactName'] as String?,
      deliveryContactMobile: json['deliveryContactMobile'] as String?,
      modelId: json['modelId']?.toString(),
      fleetId: json['fleetId']?.toString(),
      planId: json['planId']?.toString(),
      couponId: json['couponId']?.toString(),
      discount: json['discount'] as String?,
      duration: json['duration'] as String?,
      freeKm: json['freeKm'] as String?,
      baseFare: json['baseFare'] as String?,
      weekdayCharges: json['weekdayCharges'] as String?,
      weekendCharges: json['weekendCharges'] as String?,
      subTotal: json['subTotal'] as String?,
      deliveryCharges: json['deliveryCharges'] as String?,
      securityDeposit: json['securityDeposit'] as String?,
      gst: json['gst'] as String?,
      grandTotal: json['grandTotal'] as String?,
      bookingHash: json['bookingHash'] as String?,
      status: json['status'] as String?,
      odoMeterStart: json['odoMeterStart'] as String?,
      odoMeterEnd: json['odoMeterEnd'] as String?,
      fuelMeterStart: json['fuelMeterStart'] as String?,
      fuelMeterEnd: json['fuelMeterEnd'] as String?,
      differenceKm: json['differenceKm'] as String?,
      extraKm: json['extraKm'] as String?,
      extraKmAmount: json['extraKmAmount'] as String?,
      extraKmCharges: json['extraKmCharges'] as String?,
      startTime: json['startTime'] as String?,
      endTime: json['endTime'] as String?,
      transactionId: json['transactionId'] as String?,
      startBy: json['startBy'] as String?,
      endBy: json['endBy'] as String?,
      createdAt: json['created_at'] != null
          ? Timestamp.fromJson(json['created_at'] as Map<String, dynamic>)
          : null,
      modifiedAt: json['modified_at'] as String?,
      gaEventId: json['ga_event_id'] as String?,
      gaSent: json['ga_sent']?.toString(),
      cityName: json['cityName'] as String?,
      branch: json['branch'] != null
          ? Branch.fromJson(json['branch'] as Map<String, dynamic>)
          : null,
      model: json['model'] != null
          ? Model.fromJson(json['model'] as Map<String, dynamic>)
          : null,
      fleet: json['fleet'],
      payments: (json['payments'] as List<dynamic>?)
          ?.map((e) => Payment.fromJson(e as Map<String, dynamic>))
          .toList(),
      documents: (json['documents'] as List<dynamic>?)
          ?.map((e) => BookingDocument.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'bookingId': bookingId,
        'bookingNumber': bookingNumber,
        'cityId': cityId,
        'branchId': branchId,
        'bookingFrom': bookingFrom?.toIso8601String(),
        'bookingTo': bookingTo?.toIso8601String(),
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
        'cityName': cityName,
        'branch': branch?.toJson(),
        'model': model?.toJson(),
        'fleet': fleet,
        'payments': payments?.map((p) => p.toJson()).toList(),
        'documents': documents?.map((d) => d.toJson()).toList(),
      };
}

/// Generic timestamp object from your JSON (has date, timezone_type, timezone)
class Timestamp {
  Timestamp({
    this.date,
    this.timezoneType,
    this.timezone,
  });

  final String? date;
  final int? timezoneType;
  final String? timezone;

  DateTime? get dateTime {
    if (date == null) return null;
    try {
      final cleaned = date!.replaceFirst(' ', 'T');
      return DateTime.tryParse(cleaned);
    } catch (_) {
      return null;
    }
  }

  factory Timestamp.fromJson(Map<String, dynamic> json) => Timestamp(
        date: json['date'] as String?,
        timezoneType: json['timezone_type'] is int
            ? json['timezone_type'] as int
            : (json['timezone_type'] != null
                ? int.tryParse(json['timezone_type'].toString())
                : null),
        timezone: json['timezone'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'date': date,
        'timezone_type': timezoneType,
        'timezone': timezone,
      };
}

class Branch {
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

  final String? branchId;
  final String? name;
  final String? address;
  final String? contactNumber;
  final String? whatsappNumber;
  final String? contactEmail;
  final String? cityId;
  final String? status;
  final Timestamp? createdAt;
  final String? modifiedAt;

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        branchId: json['branchId']?.toString(),
        name: json['name'] as String?,
        address: json['address'] as String?,
        contactNumber: json['contactNumber'] as String?,
        whatsappNumber: json['whatsappNumber'] as String?,
        contactEmail: json['contactEmail'] as String?,
        cityId: json['cityId']?.toString(),
        status: json['status'] as String?,
        createdAt: json['created_at'] != null
            ? Timestamp.fromJson(json['created_at'] as Map<String, dynamic>)
            : null,
        modifiedAt: json['modified_at'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'branchId': branchId,
        'name': name,
        'address': address,
        'contactNumber': contactNumber,
        'whatsappNumber': whatsappNumber,
        'contactEmail': contactEmail,
        'cityId': cityId,
        'status': status,
        'created_at': createdAt?.toJson(),
        'modified_at': modifiedAt,
      };
}

class Model {
  Model({
    this.modelId,
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

  final String? modelId;
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
  final Timestamp? createdAt;
  final String? modifiedAt;

  factory Model.fromJson(Map<String, dynamic> json) => Model(
        modelId: json['modelId']?.toString(),
        fleetTypeId: json['fleetTypeId']?.toString(),
        manufacturerId: json['manufacturerId']?.toString(),
        modelName: json['modelName'] as String?,
        categoryId: json['categoryId']?.toString(),
        fuelId: json['fuelId']?.toString(),
        transmissionId: json['transmissionId']?.toString(),
        tankCapacity: json['tankCapacity'] as String?,
        airCondition: json['airCondition'] as String?,
        parkingCamera: json['parkingCamera'] as String?,
        ncapRating: json['ncapRating'] as String?,
        seater: json['seater'] as String?,
        mileage: json['mileage'] as String?,
        luggageCarrier: json['luggageCarrier'] as String?,
        varient: json['varient'] as String?,
        securityDeposit: json['securityDeposit'] as String?,
        deliveryCharges: json['deliveryCharges'] as String?,
        description: json['description'] as String?,
        image: json['image'] as String?,
        status: json['status'] as String?,
        modelHash: json['modelHash'] as String?,
        createdAt: json['created_at'] != null
            ? Timestamp.fromJson(json['created_at'] as Map<String, dynamic>)
            : null,
        modifiedAt: json['modified_at'] as String?,
      );

  Map<String, dynamic> toJson() => {
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

/// Payment shape unknown in sample; create a basic model so JSON parsing won't break
class Payment {
  Payment({
    this.id,
    this.amount,
    this.method,
    this.raw,
  });

  final String? id;
  final String? amount;
  final String? method;
  final Map<String, dynamic>? raw;

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        id: json['id']?.toString(),
        amount: json['amount']?.toString(),
        method: json['method'] as String?,
        raw: json,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'amount': amount,
        'method': method,
      };
}

class BookingDocument {
  BookingDocument({
    this.bookingDocumentId,
    this.bookingId,
    this.documentId,
    this.documentName,
    this.document,
    this.status,
    this.createdAt,
    this.modifiedAt,
    this.documentType,
  });

  final String? bookingDocumentId;
  final String? bookingId;
  final String? documentId;
  final String? documentName;
  final String? document;
  final String? status;
  final Timestamp? createdAt;
  final String? modifiedAt;
  final String? documentType;

  factory BookingDocument.fromJson(Map<String, dynamic> json) => BookingDocument(
        bookingDocumentId: json['bookingDocumentId']?.toString(),
        bookingId: json['bookingId']?.toString(),
        documentId: json['documentId']?.toString(),
        documentName: json['documentName'] as String?,
        document: json['document'] as String?,
        status: json['status'] as String?,
        createdAt: json['created_at'] != null
            ? Timestamp.fromJson(json['created_at'] as Map<String, dynamic>)
            : null,
        modifiedAt: json['modified_at'] as String?,
        documentType: json['documentType'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'bookingDocumentId': bookingDocumentId,
        'bookingId': bookingId,
        'documentId': documentId,
        'documentName': documentName,
        'document': document,
        'status': status,
        'created_at': createdAt?.toJson(),
        'modified_at': modifiedAt,
        'documentType': documentType,
      };
}
