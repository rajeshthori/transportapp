class TripModel {
  final String id;
  final String status;
  final String orderDate;
  final String akz;
  final String sourceLocation;
  final String destinationLocation;
  final String idNumber;
  final String vin;
  final String positionPrice;
  final String driverPrice;
  final String driver;
  final String driverSelection;
  final String driverIncomingInvoices;
  final String pickupStreetAddress;
  final String sourceZipCode;
  final String deliveryStreetAddress;
  final String destinationZipCode;
  final String sentToEmail;
  final String dateTime;
  final String pickup;
  final String delivery;
  final String model;
  final String pickupLocation;
  final String deliveryLocation;
  final String unitNumber;
  final String deliveredAt;
  final String pickedUpAt;
  final String orderNumber;
  final String tripClass;
  final String distance;
  final String returnTripReported;
  final String zusatzkosten;
  final String client;
  final String brand;
  final String source;
  final String destination;
  final String pickupFrom;
  final String deliveryUntil;
  final String telefonAbholung;
  final String leasing;
  final String duration;
  final String rating;
  final String textFormatiert;
  final String zufallszahl;
  final String url;
  final String feedbackLink;
  final String lieferschein;
  final String lieferscheinRueckmeldung;
  final String auftragAbholvollmacht;
  final String kmAtPickup;
  final String kmAtDelivery;
  final String auslagenNoetig;
  final String jaNein;
  final String anTelegramGesendet;
  final String serviceFee;
  final String app;

  TripModel({
    required this.id,
    required this.status,
    required this.orderDate,
    required this.akz,
    required this.sourceLocation,
    required this.destinationLocation,
    required this.idNumber,
    required this.vin,
    required this.positionPrice,
    required this.driverPrice,
    required this.driver,
    required this.driverSelection,
    required this.driverIncomingInvoices,
    required this.pickupStreetAddress,
    required this.sourceZipCode,
    required this.deliveryStreetAddress,
    required this.destinationZipCode,
    required this.sentToEmail,
    required this.dateTime,
    required this.pickup,
    required this.delivery,
    required this.model,
    required this.pickupLocation,
    required this.deliveryLocation,
    required this.unitNumber,
    required this.deliveredAt,
    required this.pickedUpAt,
    required this.orderNumber,
    required this.tripClass,
    required this.distance,
    required this.returnTripReported,
    required this.zusatzkosten,
    required this.client,
    required this.brand,
    required this.source,
    required this.destination,
    required this.pickupFrom,
    required this.deliveryUntil,
    required this.telefonAbholung,
    required this.leasing,
    required this.duration,
    required this.rating,
    required this.textFormatiert,
    required this.zufallszahl,
    required this.url,
    required this.feedbackLink,
    required this.lieferschein,
    required this.lieferscheinRueckmeldung,
    required this.auftragAbholvollmacht,
    required this.kmAtPickup,
    required this.kmAtDelivery,
    required this.auslagenNoetig,
    required this.jaNein,
    required this.anTelegramGesendet,
    required this.serviceFee,
    required this.app,
  });

  factory TripModel.fromJson(Map<String, dynamic> json) {
    String toStr(dynamic val) => val?.toString() ?? '';

    return TripModel(
      id: toStr(json['id']),
      status: toStr(json['Status']),
      orderDate: toStr(json['Order Date']),
      akz: toStr(json['AKZ']),
      sourceLocation: toStr(json['Source (Location)']),
      destinationLocation: toStr(json['Destination (Location)']),
      idNumber: toStr(json['ID Number']),
      vin: toStr(json['VIN']),
      positionPrice: toStr(json['Position Price']),
      driverPrice: toStr(json['Driver Price']),
      driver: toStr(json['Driver']),
      driverSelection: toStr(json['Driver Selection']),
      driverIncomingInvoices: toStr(json['Driver Incoming Invoices']),
      pickupStreetAddress: toStr(json['Pickup Street Address']),
      sourceZipCode: toStr(json['Source (ZIP Code)']),
      deliveryStreetAddress: toStr(json['Delivery Street Address']),
      destinationZipCode: toStr(json['Destination (ZIP Code)']),
      sentToEmail: toStr(json['Sent to Email']),
      dateTime: toStr(json['Date + Time']),
      pickup: toStr(json['Pickup']),
      delivery: toStr(json['Delivery']),
      model: toStr(json['Model']),
      pickupLocation: toStr(json['Pickup Location']),
      deliveryLocation: toStr(json['Delivery Location']),
      unitNumber: toStr(json['Unit Number']),
      deliveredAt: toStr(json['Delivered At']),
      pickedUpAt: toStr(json['Picked Up At']),
      orderNumber: toStr(json['Order Number']),
      tripClass: toStr(json['Class']),
      distance: toStr(json['Distance']),
      returnTripReported: toStr(json['Return Trip Reported']),
      zusatzkosten: toStr(json['Zusatzkosten Wartezeit usw']),
      client: toStr(json['Client']),
      brand: toStr(json['Brand']),
      source: toStr(json['Source']),
      destination: toStr(json['Destination']),
      pickupFrom: toStr(json['Pickup From']),
      deliveryUntil: toStr(json['Delivery Until']),
      telefonAbholung: toStr(json['Telefon Abholung']),
      leasing: toStr(json['Leasing ? zusätzliche Daten']),
      duration: toStr(json['Duration']),
      rating: toStr(json['Rating']),
      textFormatiert: toStr(json['Text (formatiert)']),
      zufallszahl: toStr(json['Zufallszahl']),
      url: toStr(json['URL']),
      feedbackLink: toStr(json['Link für Rückmeldeformular']),
      lieferschein: toStr(json['Lieferschein']),
      lieferscheinRueckmeldung: toStr(json['Lieferschein Rückmeldung']),
      auftragAbholvollmacht: toStr(json['Auftrag / Abholvollmacht']),
      kmAtPickup: toStr(json['Km at Pickup']),
      kmAtDelivery: toStr(json['Km at Delivery']),
      auslagenNoetig: toStr(json['waren Auslagen nötig']),
      jaNein: toStr(json['Ja / Nein']),
      anTelegramGesendet: toStr(json['an telegram gesendet']),
      serviceFee: toStr(json['Servicegebühr']),
      app: toStr(json['App']),
    );
  }
}
