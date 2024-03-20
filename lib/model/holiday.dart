class Holiday {
  int? id;
  String? name;
  String? startFrom;
  String? endAt;
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

  factory Holiday.fromJson(Map<String, dynamic> json) {
    return Holiday(
      id: json['id'],
      name: json['name'],
      startFrom: json['start_from'].toString(),
      endAt: json['end_at'].toString(),
      dayAmount: json['day_amount'],
      description: json['description'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = name;
    data["start_from"] = startFrom;
    data["end_at"]=endAt ;
    data["day_amount"] = dayAmount;
    data["description"]=description;
    return data;
  }
}
