import 'branch.dart';

class CompanyResponse {
  List<Company>? list;

  CompanyResponse({
    this.list,
  });
  CompanyResponse.fromJson(Map<String, dynamic> json) {
    list = (json["body"] as List).map((json) => Company.fromJson(json)).toList();

  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["body"] = list;
    return data;
  }
}

class Company {
  int? id;
  String? name;
  // String? photo;
  String? phone;
  String? email;
  String? companyBio;
  int? parentCompId;
  String? establishedDate;
  List<Branch>? branchess;

 Company({
    this.id,
    this.name,
    // this.photo,
    this.phone,
    this.email,
    this.parentCompId,
    this.companyBio,
    this.establishedDate,
    this.branchess
  });

  Company.fromJson(Map<String, dynamic> json) {
    List<dynamic> temp = json["branches"];
    id = json["id"];
    name = json["name"];
    email = json["email"];
    phone = json["phone"];
    // photo=json["photo"]; after uncomment this, make sure to uncomment in company_profile.dart
    establishedDate = json["established_date"];
    parentCompId = json["parent_company"];
    companyBio = json["bio"];
    branchess = temp.map((e) => Branch.fromJson(e)).toList();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["email"] = email;
    data["phone"] = phone;
    data["established_date"] = establishedDate;
    data["parent_company"] = parentCompId;
    data["bio"] = companyBio;
    data["branches"] = branchess;
    // data["profile_picture"] = photo;
    return data;
  }
}
