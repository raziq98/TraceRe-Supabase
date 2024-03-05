class UserResponse {
  int? itemCount;
  List<Users>? list;

  UserResponse({
    this.list,
    this.itemCount,
  });
  UserResponse.fromJson(Map<String, dynamic> json) {
    itemCount = json["itemCount"];
    list = (json["body"] as List).map((json) => Users.fromJson(json)).toList();

  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["itemCount"] = itemCount;
    data["body"] = list;
    return data;
  }
}

class Users {
  int? id;
  String? name;
  String? userCode;
  String? address;
  int? postalCode;
  String? country;
  String? photo;
  String? phone;
  String? email;
  String? password;
  int? roleId;
  String? branchCode;
  int? departmentId;
  bool? isAvailable;
  bool? isOffDay;
  String? dateOfBirth;
  int? branchId;
  int? levelId;

 Users({
    this.id,
    this.name,
    this.userCode,
    this.address,
    this.postalCode,
    this.country,
    this.photo,
    this.phone,
    this.email,
    this.password,
    this.roleId,
    this.branchCode,
    this.departmentId,
    this.isAvailable,
    this.isOffDay,
    this.dateOfBirth,
  });

  Users.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    email = json["email"];
    userCode = json["code"];
    address = json["address"];
    country = json["country"];
    phone = json["phone"];
    password = json["password"];
    dateOfBirth = json["date_of_birth"];
    roleId = json["role_id"];
    branchCode = json["current_company"];
    departmentId = json["department_id"];
    photo = json["profile_picture"];
    isAvailable = json["is_available"];
    isOffDay = json["is_offday"];
    postalCode = json["postal_code"];
    branchId = json['branch_id'];
    levelId = json['level_id'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["email"] = email;
    data["code"] = userCode;
    data["address"] = address;
    data["country"] = country;
    data["phone"] = phone;
    data["password"] = password;
    data["date_of_birth"] = dateOfBirth;
    data["role_id"] = roleId;
    data["current_company"] = branchCode;
    data["department_id"] = departmentId;
    data["profile_picture"] = photo;
    data["is_available"] = isAvailable;
    data["is_offday"] = isOffDay;
    data["postal_code"]=postalCode ;
    data['branch_id']=branchId;
    data['level_id']=levelId;
    return data;
  }
}
