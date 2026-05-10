class ImageDetail {
  String id;
  String path;
  String location;
  String subSelection;

  // Constructor
  ImageDetail({
    required this.path,
    required this.location,
    required this.subSelection,
    required this.id,
  });

  // Convert to JSON
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['path'] = path;
    data['location'] = location;
    data['subSelection'] = subSelection;
    return data;
  }

  ImageDetail.fromMap(Map<String, dynamic> json)
      : path = json['path'],
        id = json['id'],
        location = json['location'],
        subSelection = json['subSelection'];
}
