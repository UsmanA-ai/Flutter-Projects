class GeneralDetailsModel {
  String refNo;
  String myRef;
  String region;
  String houseName;
  String houseNo;
  String street;
  String locality;
  String country;
  String town;
  String postCode;
  String date;
  String property;
  String riskAssessment;
  bool isAdded;

  GeneralDetailsModel({
    required this.refNo,
    required this.myRef,
    required this.region,
    required this.houseName,
    required this.houseNo,
    required this.street,
    required this.locality,
    required this.country,
    required this.town,
    required this.postCode,
    required this.date,
    required this.property,
    required this.riskAssessment,
    required this.isAdded,
  });

  // Convert GeneralDetailsModel to a Map
  Map<String, dynamic> toMap() {
    return {
      'refNo': refNo,
      'myRef': myRef,
      'region': region,
      'houseName': houseName,
      'houseNo': houseNo,
      'street': street,
      'locality': locality,
      'country': country,
      'town': town,
      'postCode': postCode,
      'date': date,
      "property": property,
      "riskAssessment": riskAssessment,
      "isAdded": isAdded,
    };
  }

  // Create GeneralDetailsModel from a Map
  factory GeneralDetailsModel.fromMap(Map<String, dynamic> map) {
    return GeneralDetailsModel(
      riskAssessment: map["riskAssessment"] ?? "",
      refNo: map['refNo'] ?? '',
      myRef: map['myRef'] ?? '',
      region: map['region'] ?? '',
      houseName: map['houseName'] ?? '',
      houseNo: map['houseNo'] ?? '',
      street: map['street'] ?? '',
      locality: map['locality'] ?? '',
      country: map['country'] ?? '',
      town: map['town'] ?? '',
      postCode: map['postCode'] ?? '',
      date: map['date'] ?? '',
      property: map['property'] ?? '',
      isAdded: map["isAdded"] ?? false,
    );
  }
}
