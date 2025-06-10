class Cancelmodel {
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
  final String orderNumber;
  final String tripClass;
  final String distance;
  final String returnTripReported;
  final String zusatzkosten;
  final String brand;
  final String source;
  final String destination;
  final String pickupFrom;
  final String deliveryUntil;
  final String telefonLieferung;
  final String leasing;
  final String duration;
  final String rating;
  final String nameFahrer;
  final String zufallszahl;
  final String feedbackLink;
  final String auslagenNoetig;
  final String jaNein;
  final String serviceFee;

  Cancelmodel({
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
    required this.orderNumber,
    required this.tripClass,
    required this.distance,
    required this.returnTripReported,
    required this.zusatzkosten,
    required this.brand,
    required this.source,
    required this.destination,
    required this.pickupFrom,
    required this.deliveryUntil,
    required this.telefonLieferung,
    required this.leasing,
    required this.duration,
    required this.rating,
    required this.nameFahrer,
    required this.zufallszahl,
    required this.feedbackLink,
    required this.auslagenNoetig,
    required this.jaNein,
    required this.serviceFee,
  });

  factory Cancelmodel.fromJson(Map<String, dynamic> json) {
    String toStr(dynamic val) => val?.toString() ?? '';

    return Cancelmodel(
      id: toStr(json['id']),
      status: toStr(json['Status']),
      orderDate: toStr(json['Order Date']),
      akz: toStr(json['AKZ']),
      sourceLocation: toStr(json['Source (Location)']),
      destinationLocation: toStr(json['Destination (Location)']),
      idNumber: toStr(json['ID Number']),
      vin: toStr(json['VIN']),
      positionPrice: toStr(json['Position Price'] ?? 0),
      driverPrice: toStr(json['Driver Price'] ?? 0),
      driver: toStr(json['Driver']),
      driverSelection: toStr(json['Driver Selection']),
      driverIncomingInvoices: toStr(json['Driver Incoming Invoices'] ?? 0),
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
      orderNumber: toStr(json['Order Number']),
      tripClass: toStr(json['Class']),
      distance: toStr(json['Distance'] ?? 0),
      returnTripReported: toStr(json['Return Trip Reported']),
      zusatzkosten: toStr(json['Zusatzkosten Wartezeit usw'] ?? 0),
      brand: toStr(json['Brand']),
      source: toStr(json['Source']),
      destination: toStr(json['Destination']),
      pickupFrom: toStr(json['Pickup From']),
      deliveryUntil: toStr(json['Delivery Until']),
      telefonLieferung: toStr(json['Telefon Lieferung']),
      leasing: toStr(json['Leasing ? zusätzliche Daten']),
      duration: toStr(json['Duration']),
      rating: toStr(json['Rating']),
      nameFahrer: toStr(json['Name Fahrer']),
      zufallszahl: toStr(json['Zufallszahl']),
      feedbackLink: toStr(json['Link für Rückmeldeformular']),
      auslagenNoetig: toStr(json['waren Auslagen nötig']),
      jaNein: toStr(json['Ja / Nein']),
      serviceFee: toStr(json['Servicegebühr'] ?? 0),
    );
  }
}
