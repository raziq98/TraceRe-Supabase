// ignore_for_file: prefer_if_null_operators

class SettingModels {
  int? id;
  int? customWorkHour;
  bool? hasSetMaxOffday;
  int? maxOffdayNum;
  bool? is8hr;
  int? companyId;
  int? branchId;
  bool? is90dayDataRemoval;
  int? customDataRemovalDay;

  SettingModels({
    this.id,
    this.customWorkHour,
    this.hasSetMaxOffday,
    this.branchId,
    this.companyId,
    this.is8hr,
    this.maxOffdayNum,
    this.customDataRemovalDay,
    this.is90dayDataRemoval,
  });

  SettingModels.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    customWorkHour = json["customWorkhr"];
    hasSetMaxOffday = json["hasSetMaxOffday"];
    branchId = json["branch_id"];
    companyId = json["company_id"];
    is8hr = json["isApply8hr"];
    maxOffdayNum = json['maxOffdayNum'];
    customDataRemovalDay = json["customRemovalDay"];
    is90dayDataRemoval = json["is90dayDataRemoval"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id == null ? 1 : id;
    data["customWorkhr"] = customWorkHour == null ? 8 : customWorkHour;
    data["hasSetMaxOffday"] = hasSetMaxOffday == null ? false : hasSetMaxOffday;
    data["maxOffdayNum"] = maxOffdayNum == null ? 0 : maxOffdayNum;
    data["isApply8hr"] = is8hr == null ? true : is8hr;
    data["branch_id"] = branchId == null ? 1 : branchId;
    data["company_id"] = companyId == null ? 1 : companyId;
    data["customRemovalDay"] =
        customDataRemovalDay == null ? 0 : customDataRemovalDay;
    data["is90dayDataRemoval"] =
        is90dayDataRemoval == null ? true : is90dayDataRemoval;
    return data;
  }

  @override
  String toString() {
    return 'SettingModels{id: $id, customWorkhr: $customWorkHour, hasSetMaxOffday: $hasSetMaxOffday, '
        'maxOffdayNum: $maxOffdayNum, isApply8hr: $is8hr, branchId: $branchId, companyId: $companyId, '
        'customRemovalDay: $customDataRemovalDay, is90dayDataRemoval: $is90dayDataRemoval}';
  }
}
