class EmployeeModel{
  String id;
  String employeeName;
  String employeeAge;
  String employeeSalary;
  String profileImage;

  EmployeeModel({
    this.id,
    this.employeeName,
    this.employeeAge,
    this.employeeSalary,
    this.profileImage,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) => EmployeeModel(
    id: json['id'],
    employeeName: json['employee_name'],
    employeeAge: json['employee_age'],
    employeeSalary: json['employee_salary'],
    profileImage: json['profile_image'],
  );
}