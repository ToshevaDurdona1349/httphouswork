class Examplee {
  int? id;
  String? exampleeName;
  int? exampleeSalary;
  int? exampleeAge;
  String? profileImage;

  Examplee({this.id, this.exampleeName, this.exampleeSalary, this.exampleeAge,this.profileImage});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'employeeName': exampleeName,
      'employeeSalary': exampleeSalary,
      'employeeAge': exampleeAge,
      'profileImage':profileImage
    };
  }

  static Examplee fromMap(Map map) {
    Examplee employee = Examplee();
    employee.id = map['id'];
    employee.exampleeName = map['exampleeName'];
    employee.exampleeSalary = map['exampleeSalary'];
    employee.exampleeAge = map['exampleeAge'];
    employee.profileImage=map['profileImage'];
    return employee;
  }
}