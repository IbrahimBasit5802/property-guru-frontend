class StoredEmployees {
 late final String empID;
  late final String empName;
  late final String empType;

  StoredEmployees({ required this.empID, required this.empName, required this.empType});

  StoredEmployees.fromJson(Map<String, dynamic> json) {
    empID = json['empID'];
    empName = json['empName'];
    empType = json['empType'];
  }

  Map<String,dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['empID'] = this.empID;
    data['empName'] = this.empName;
    data['empType'] = this.empType;
    return data;
  }
}