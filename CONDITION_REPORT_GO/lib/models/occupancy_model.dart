class OccupancyModel {
  String totalOccupants;
  String childrenUnder18;
  String pensionableMembers;
  String disabledMembers;
  String? specialConsideration;
  bool isAdded;

  OccupancyModel({
    required this.totalOccupants,
    required this.childrenUnder18,
    required this.pensionableMembers,
    required this.disabledMembers,
    this.specialConsideration,
    required this.isAdded,
  });

  // Convert OccupancyModel to a Map
  Map<String, dynamic> toMap() {
    return {
      'totalOccupants': totalOccupants,
      'childrenUnder18': childrenUnder18,
      'pensionableMembers': pensionableMembers,
      'disabledMembers': disabledMembers,
      'specialConsideration': specialConsideration,
      "isAdded": isAdded,
    };
  }

  // Create OccupancyModel from a Map
  factory OccupancyModel.fromMap(Map<String, dynamic> map) {
    return OccupancyModel(
      totalOccupants: map['totalOccupants'] ?? '',
      childrenUnder18: map['childrenUnder18'] ?? '',
      pensionableMembers: map['pensionableMembers'] ?? '',
      disabledMembers: map['disabledMembers'] ?? '',
      specialConsideration:
          map['specialConsideration'], // Null-safe since it's optional
      isAdded: map["isAdded"] ?? false,
    );
  }
}
