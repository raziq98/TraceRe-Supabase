class Holiday {
  int? id;
  String? name;
  DateTime? startFrom;
  DateTime? endAt;
  int? dayAmount;
  String? description;
 Holiday({
    this.id,
    this.name,
    this.startFrom,
    this.endAt,
    this.dayAmount,
    this.description,
  });

  Holiday.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    startFrom = json["start_from"];
    dayAmount = json["day_amount"];
    endAt = json["end_at"];
    description=json["description"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["start_from"] = startFrom;
    data["day_amount"] = dayAmount;
    data["end_at"]=endAt ;
    data["description"]=description;
    return data;
  }
}
