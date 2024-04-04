class Department {
  int? id;
  String? companyName;
  String? companyDesc;

 Department({
    this.id,
    this.companyName,
    this.companyDesc,
  });

  Department.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    companyName = json["name"];
    companyDesc = json["description"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = companyName;
    data["description"] = companyDesc;
    return data;
  }
}
