class NewElementModel {
  String elementName;
  String conditionSummaryText;
  String selectedElementType;
  String selectedElement;
  String isWindow;
  String isUnderCut;
  String isTrickleEvent;
  String isFluedHeating;
  String isGapInUnderCut;
  String isFanFitted;
  String isExistingVentilation;
  String isDamp;
  String? additionalNotes;
  List<String>? conditionSummaryImage;
  List<String>? trickleEventImage;
  List<String>? internalDoorImage;

  // Constructor
  NewElementModel({
    required this.selectedElementType,
    required this.conditionSummaryText,
    required this.elementName,
    required this.selectedElement,
    required this.isWindow,
    required this.isUnderCut,
    required this.isTrickleEvent,
    required this.isFluedHeating,
    required this.isGapInUnderCut,
    required this.isFanFitted,
    required this.isExistingVentilation,
    required this.isDamp,
    this.additionalNotes,
    this.conditionSummaryImage,
    this.trickleEventImage,
    this.internalDoorImage,
  });

  // Convert instance to Map
  Map<String, dynamic> toMap() {
    return {
      'selectedElementType': selectedElementType,
      'selectedElement': selectedElement,
      'isWindow': isWindow,
      'isUnderCut': isUnderCut,
      'isTrickleEvent': isTrickleEvent,
      'isFluedHeating': isFluedHeating,
      'isGapInUnderCut': isGapInUnderCut,
      'isFanFitted': isFanFitted,
      'isExistingVentilation': isExistingVentilation,
      'isDamp': isDamp,
      'additionalNotes': additionalNotes,
      'conditionSummaryImage': conditionSummaryImage,
      'trickleEventImage': trickleEventImage,
      'internalDoorImage': internalDoorImage,
      'conditionSummaryText': conditionSummaryText,
      'elementName': elementName,
    };
  }

  // Create instance from Map
  factory NewElementModel.fromMap(Map<String, dynamic> map) {
    return NewElementModel(
      selectedElementType: map['selectedElementType'] ?? '',
      selectedElement: map['selectedElement'] ?? '',
      isWindow: map['isWindow'] ?? '',
      elementName: map['elementName'] ?? '',
      conditionSummaryText: map['conditionSummaryText'] ?? '',
      isUnderCut: map['isUnderCut'] ?? '',
      isTrickleEvent: map['isTrickleEvent'] ?? '',
      isFluedHeating: map['isFluedHeating'] ?? '',
      isGapInUnderCut: map['isGapInUnderCut'] ?? '',
      isFanFitted: map['isFanFitted'] ?? '',
      isExistingVentilation: map['isExistingVentilation'] ?? '',
      isDamp: map['isDamp'] ?? '',
      additionalNotes: map['additionalNotes'],
      conditionSummaryImage: (map['conditionSummaryImage'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      trickleEventImage: (map['trickleEventImage'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      internalDoorImage: (map['internalDoorImage'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );
  }
}
