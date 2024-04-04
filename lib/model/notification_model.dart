class MyNotification {
  int? id;
  String? sender;
  DateTime? createdDate;
  int? statusId;
  int? sendTo;
  int? requestType;
  DateTime? requestedDateFrom;
  DateTime? requestedDateTo;
  String? description;
  String? suggestion;
  bool isRead=false;

  MyNotification({
    this.id,
    this.sender,
    this.createdDate,
    this.statusId,
    this.sendTo,
    this.requestType,
    this.requestedDateFrom,
    this.requestedDateTo,
    this.description,
    this.suggestion,
  });

  MyNotification.fromJson(Map<String, dynamic> json) {
    id=json["id"];
    sender = json["sender"];
    createdDate = json["created_at"];
    statusId = json["status_id"];
    sendTo = json["send_to"];
    requestType = json["request_type_id"];
    requestedDateFrom=json["requested_from"];
    requestedDateTo = json["requested_to"];
    description = json["description"];
    suggestion=json["suggestion"];
    isRead=json["is_read"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"]=id;
    data["sender"] = sender;
    data["created_at"] = createdDate;
    data["status_id"] = statusId;
    data["send_to"] = sendTo;
    data["request_type_id"]=requestType ;
    data["requested_from"]=requestedDateFrom;
    data["requested_to"] = requestedDateTo;
    data["description"]=description ;
    data["suggestion"]=suggestion;
    data["is_read"]=isRead;
    return data;
    }

}
