import 'package:flutter/material.dart';
import 'package:httphouswork/models/employee_model.dart';
import '../service/http_service.dart';
import '../service/log_service.dart';

class UpdatePage extends StatefulWidget {
  final Employee employee;
  const UpdatePage({super.key, required this.employee});

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  // final TextEditingController _idController = TextEditingController();

  _updatePost() async{
    String name = _nameController.text.toString().trim();
    String salary = _salaryController.text.toString().trim();
    String age = _ageController.text.toString().trim();
    // String id = _idController.text.toString().trim();

    Employee newEmployee = widget.employee;
    newEmployee.employeeName=name;
    newEmployee.employeeSalary=int.parse(salary);
    newEmployee.employeeAge=int.parse(age);
    newEmployee.profileImage= '';
    // newEmployee.id=int.parse(id) ;

    var response = await Network.PUT(
        Network.API_EMPLOYEE_UPDATE + newEmployee.id.toString(),
        Network.paramsUpdate(newEmployee));
    LogService.d(response!);
    // EmployeeRes employeeRes=Network.parseEmployeeRes(response);
    backToFinish();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController.text=widget.employee.employeeName;
    _salaryController.text=widget.employee.employeeSalary.toString();
    _ageController.text=widget.employee.employeeAge.toString();
    // _idController.text=widget.employee.id.toString();

  }

  backToFinish(){
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    // keyvord ekran hohlagan joyini bossa yo'qolad
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Update Post"),
        ),
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                      hintText: "Title"
                  ),
                ),
              ),
              Container(
                child: TextField(
                  controller: _salaryController,
                  decoration: InputDecoration(
                      hintText: "Salary"
                  ),
                ),
              ), Container(
                child: TextField(
                  controller:  _ageController,
                  decoration: InputDecoration(
                      hintText: "Age"
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 10),
                  width: double.infinity,
                  child: MaterialButton(
                    color: Colors.blue,
                    onPressed: () {
                      _updatePost();
                    },
                    child: Text("Update"),
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
