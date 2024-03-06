class WorkType {
  int? id;
  String? name;
  String? description;

  WorkType({
    this.id,
    this.name,
    this.description,
  });

  WorkType.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    description = json["description"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["description"] = description;
    return data;
  }
}
